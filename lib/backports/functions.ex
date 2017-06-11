defmodule Backports.Functions do
  alias Backports.Constants

  defmacro before_compile(_env) do
    dispatch(Constants.elixir_version)
  end

  defp dispatch({1, 2, _}) do
    [
      trim()
    ]
  end

  defp dispatch({1, 1, _}) do
    [
      trim()
    ]
  end

  defp dispatch(_) do
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
