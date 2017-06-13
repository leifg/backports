defmodule PadTrailingWrapper do
  use Backports

  # pad_trailing/2

  def pad_trailing(string, count) do
    String.pad_trailing(string, count)
  end

  # pad_trailing/3

  def pad_trailing(string, count, padding) do
    String.pad_trailing(string, count, padding)
  end
end
