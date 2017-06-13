defmodule PadLeadingTest do
  use ExUnit.Case

  # pad_leading/2

  test "PadLeadingWrapper returns correct string" do
    assert PadLeadingWrapper.pad_leading("abc", 5) == "  abc"
  end

  # pad_leading/3

  test "PadLeadingWrapper returns correct strill with padding" do
    assert PadLeadingWrapper.pad_leading("abc", 10, ["123"]) == "123123123123123123123abc"
  end
end
