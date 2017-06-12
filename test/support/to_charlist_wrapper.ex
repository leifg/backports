defmodule ToCharlistWrapper do
  use Backports

  def to_charlist(string) do
    String.to_charlist(string)
  end

  def to_charlist_tuple_2(string) do
    {String.to_charlist(string), String.to_charlist(string)}
  end

  def to_charlist_tuple_2_with_array(string) do
    {String.to_charlist(string), ["a", "b"]}
  end

  def to_charlist_tuple_3(string) do
    {String.to_charlist(string), String.to_charlist(string), String.to_charlist(string)}
  end
end
