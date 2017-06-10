defmodule Backports do
  defmacro __using__(_) do
    quote do
      Module.register_attribute __MODULE__, :functions, accumulate: true
      Module.register_attribute __MODULE__, :backport, accumulate: true

      @on_definition {Backports, :on_definition}
      @before_compile {Backports, :before_compile}
    end
  end

  defmacro before_compile(env) do
    functions = Module.get_attribute(env.module, :functions) |> Enum.reverse
    to_override = Module.get_attribute(env.module, :backport) |> Enum.uniq
    overridable_function_definitions = functions
      |> Enum.filter(&to_override?(&1, to_override))
      |> Enum.map(&render_fun/1)

    quoted_overridable(to_override) ++ overridable_function_definitions
  end

  def on_definition(env, kind, fun, args, guards, body) do
    parameters = {kind, fun, args, guards, body}
    Module.put_attribute(env.module, :functions, parameters)
    if change?(body, false) do
      Module.put_attribute(env.module, :backport, {fun, length(args)})
    end
  end

  defp to_override?({_kind, name, args, _guards, _body}, reference) do
    Enum.member?(reference, {name, length(args)})
  end

  defp quoted_overridable([]) do
    []
  end

  defp quoted_overridable(function_defintions) do
    [quote do: defoverridable unquote(function_defintions)]
  end

  defp change?(_args, true), do: true
  defp change?({:., _meta1, [{_aliases, _meta2, aliases}, function_name]}, _found) do
    Lookup.get(aliases, function_name) != nil
  end
  defp change?({:__block__, meta, [head | rest]}, found) do
    result = change?(head, found)
    change?({:__block__, meta, rest}, result)
  end
  defp change?({call, _meta, _args}, found) do
    change?(call, found)
  end
  defp change?(_body, _found), do: false

  defp render_fun({kind, fun, args, [], body}) do
    quote do
      Kernel.unquote(kind)(unquote(fun)(unquote_splicing(args))) do
        unquote(backport(body))
      end
    end
  end

  defp render_fun({kind, fun, args, guard, body}) do
    quote do
      Kernel.unquote(kind)(unquote(fun)(unquote_splicing(args)) when unquote_splicing(guard)) do
        unquote(backport(body))
      end
    end
  end

  defp backport({:., meta1, [{:__aliases__, meta2, aliases}, function_name]} = input) do
    case Lookup.get(aliases, function_name) do
      nil -> input
      {replace_aliases, replace_function} -> {:., meta1, [{:__aliases__, meta2, replace_aliases}, replace_function]}
    end
  end
  defp backport({call, meta, args}) when is_list(args) do
    {backport(call), meta, Enum.map(args, fn(input) -> backport(input) end)}
  end
  defp backport(input), do: input
end
