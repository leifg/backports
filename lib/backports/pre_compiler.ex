defmodule Backports.PreCompiler do
  alias Backports.Constants

  defmacro before_compile(env) do
    dispatch(env.module, Constants.elixir_version)
  end

  defp dispatch(Backports.Functions.String, {1, 2, _}) do
    [
      trim(),
      to_charlist(),
      pad(),
    ]
  end

  defp dispatch(Backports.Functions.String, {1, 1, _}) do
    [
      trim(),
      to_charlist(),
      pad(),
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

  defp to_charlist do
    quote do
      def to_charlist(string) do
        String.to_char_list(string)
      end
    end
  end

  defp pad do
    quote do
      def pad_leading(string, count, padding \\ [" "])

      def pad_leading(string, count, padding) when is_binary(padding) do
        pad_leading(string, count, String.graphemes(padding))
      end

      def pad_leading(string, count, [_ | _] = padding)
          when is_binary(string) and is_integer(count) and count >= 0 do
        pad(:leading, string, count, padding)
      end

      def pad_trailing(string, count, padding \\ [" "])

      def pad_trailing(string, count, padding) when is_binary(padding) do
        pad_trailing(string, count, String.graphemes(padding))
      end

      def pad_trailing(string, count, [_ | _] = padding)
          when is_binary(string) and is_integer(count) and count >= 0 do
        pad(:trailing, string, count, padding)
      end

      defp pad(kind, string, count, padding) do
        string_len = String.length(string)
        if string_len >= count do
          string
        else
          filler = build_filler(count - string_len, padding, padding, 0, [])
          case kind do
            :leading -> [filler | string]
            :trailing -> [string | filler]
          end
          |> IO.iodata_to_binary
        end
      end

      defp build_filler(0, _source, _padding, _size, filler), do: filler

      defp build_filler(count, source, [], size, filler) do
        rem_filler =
          rem(count, size)
          |> build_filler(source, source, 0, [])
        filler =
          filler
          |> IO.iodata_to_binary
          |> String.duplicate(div(count, size) + 1)
        [filler | rem_filler]
      end

      defp build_filler(count, source, [elem | rest], size, filler)
          when is_binary(elem) do
        build_filler(count - 1, source, rest, size + 1, [filler | elem])
      end

      defp build_filler(_count, _source, [elem | _rest], _size, _filler) do
        raise ArgumentError, "expected a string padding element, got: #{inspect(elem)}"
      end
    end
  end
end
