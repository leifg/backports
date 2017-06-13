defmodule PadLeadingWrapper do
  use Backports

  # pad_leading/2

  def pad_leading(string, count) do
    String.pad_leading(string, count)
  end

  # pad_leading/3

  def pad_leading(string, count, padding) do
    String.pad_leading(string, count, padding)
  end
end
