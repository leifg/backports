defmodule TrimTest do
  use ExUnit.Case

  # trim/1

  test "TrimWrapper returns nil value for nil input" do
    assert TrimWrapper.trim(nil) == nil
  end

  test "TrimWrapper returns correct trim" do
    assert TrimWrapper.trim("  before") == "before"
  end

  test "TrimWrapper returns correct space input" do
    assert TrimWrapper.trim("  ") == "special"
  end

  test "TrimWrapper returns correct output for list input" do
    assert TrimWrapper.trim(["  before  ", "  after    "]) == ["before", "after"]
  end
end