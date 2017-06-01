defmodule Wrapper do
  use Backports

  def trim(nil) do
    nil
  end

  def trim(input) do
    String.what(input)
  end


  def nothing_special do
    1 == 1
  end
end
