defmodule TrimWrapper do
  use Backports

  def trim(nil) do
    nil
  end

  def trim("  ") do
    String.trim(" special ")
  end

  def trim(input) when is_list(input) do
    Enum.map(input, &String.trim/1)
  end

  def trim(input) do
    String.trim(input)
  end

  def trim(input, to_trim) do
    String.trim(input, to_trim)
  end

  def trim_piped(input) do
    input |> String.trim
  end

  def trim_nested(input) do
    String.downcase(String.upcase(String.downcase(String.trim(input))))
  end

  def trim_with_condition(input, minimum) do
    if minimum > 0 do
      "extra line" == "extra line"
      String.trim(input)
    end
  end

  def nothing_special do
    1 == 1
  end
end
