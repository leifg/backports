defmodule Backports.PreCompiler do
  alias Backports.Constants

  defmacro before_compile(env) do
    dispatch(env.module, Constants.elixir_version)
  end

  defp dispatch(Backports.Functions.String, {1, 2, _}) do
    [
      trim()
    ]
  end

  defp dispatch(Backports.Functions.String, {1, 1, _}) do
    [
      trim()
    ]
  end

  defp dispatch(_, _) do
    []
  end

  defp trim do
    quote do
      def trim(string) do
        String.strip(string)
      end

      def trim(string, to_trim) do
        [char | _ ] = String.to_char_list(to_trim)
        String.strip(string, char)
      end
    end
  end
end
