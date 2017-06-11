defmodule ToCharlistWrapper do
  use Backports

  def to_charlist(string) do
    String.to_charlist(string)
  end
end
