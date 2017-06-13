defmodule PadTrailingTest do
  use ExUnit.Case

  # pad_trailing/2

  test "PadTrailingWrapper returns correct string" do
    assert PadTrailingWrapper.pad_trailing("abc", 5) == "abc  "
  end

  # pad_trailing/3

  test "PadTrailingWrapper returns correct strill with padding" do
    assert PadTrailingWrapper.pad_trailing("abc", 10, ["123"]) == "abc123123123123123123123"
  end
end
