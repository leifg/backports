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

  def trim_with_short_condition(input, minimum) do
    else_return = ""
    if minimum > 0, do: String.trim(input), else: else_return
  end

  def trim_with_condition(input, minimum) do
    if minimum > 0 do
      # extra line for edge cases
      input_2 = String.trim(input)
      String.trim(input_2)
    end
  end

  def trim_with_condition_and_else(input, minimum) do
    if minimum > 0 do
      String.trim(input)
    else
      String.trim(input)
    end
  end

  def delayed_trim(input) do
    fun = fn(inner) -> String.trim(inner) end
    fun.(input)
  end

  def nothing_special do
    1 == 1
  end
end
