defmodule PadLeadingWrapper do
  use Backports

  # pad_leading/2

  def pad_leading(string, count) do
    String.pad_leading(string, count)
  end

  def pad_leading_in_list(string, count) do
    [:reset, String.pad_leading(string, count), :faint, " #{string}\n"]
  end

  # pad_leading/3

  def pad_leading(string, count, padding) do
    String.pad_leading(string, count, padding)
  end
end
