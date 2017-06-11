defmodule Backports do
  alias Backports.Functions

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
    Functions.backport?(aliases, function_name)
  end
  defp change?({call, meta, [head | rest]}, found) do
    result = change?(head, found)
    change?({call, meta, rest}, result)
  end
  defp change?([do: {call, meta, args}], found) do
    change?({call, meta, args}, found)
  end
  defp change?([do: {call, meta, args}, else: {else_call, else_meta, else_args}], found) do
    result = change?({call, meta, args}, found)
    change?({else_call, else_meta, else_args}, result)
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
    case Functions.get(aliases, function_name) do
      nil -> input
      {replace_aliases, replace_function} -> {:., meta1, [{:__aliases__, meta2, replace_aliases}, replace_function]}
    end
  end
  defp backport(do: do_statements) do
    [do: replace_node(do_statements)]
  end
  defp backport(do: do_statements, else: else_statements) do
    [
      do: replace_node(do_statements),
      else: replace_node(else_statements),
    ]
  end
  defp backport(input) do
    replace_node(input)
  end

  defp replace_node({call, meta, args}) when is_list(args) do
    {backport(call), meta, Enum.map(args, &backport/1)}
  end

  defp replace_node({call, meta, arg}) do
    {backport(call), meta, backport(arg)}
  end

  defp replace_node(input) do
    input
  end
end
