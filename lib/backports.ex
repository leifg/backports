defmodule Backports do
  @backports %{
    {[:String], :what} => {[:String], :trim}
  }
  defmacro __using__(_) do
    quote do
      Module.register_attribute __MODULE__, :functions, accumulate: true
      Module.register_attribute __MODULE__, :backport, accumulate: true

      @on_definition {Backports, :on_definition}
      @before_compile {Backports, :before_compile}
    end
  end

  defmacro before_compile(env) do
    Module.get_attribute(env.module, :backport) |> IO.inspect
    quote do
      defoverridable [trim: 1]

      def trim(nil) do
        nil
      end

      def trim(input) do
        String.trim(input)
      end
    end
  end

  def on_definition(env, kind, fun, args, guards, body) do
    parameters = {kind, fun, args, guards, body}
    Module.put_attribute(env.module, :functions, parameters)
    if change?(body, false) do
      Module.put_attribute(env.module, :backport, {fun, length(args)})
    end
  end

  defp change?(_args, true), do: true
  defp change?({:., _meta1, [{_aliases, _meta2, aliases}, function_name]}, _found) do
    @backports[{aliases, function_name}] != nil
  end
  defp change?({:__block__, meta, [head | rest]}, found) do
    result = change?(head, found)
    change?({:__block__, meta, rest}, result)
  end
  defp change?({call, _meta, _args}, found) do
    change?(call, found)
  end
  defp change?(_body, _found), do: false
end
