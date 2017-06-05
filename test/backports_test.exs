defmodule BackportsTest do
  use ExUnit.Case

  test "Wrapper returns nil value for nil input" do
    assert Wrapper.trim(nil) == nil
  end

  test "Wrapper returns correct trim" do
    assert Wrapper.trim("  before") == "before"
  end

  test "Wrapper returns correct space input" do
    assert Wrapper.trim("  ") == "special"
  end

  test "Wrapper returns correct output for list input" do
    assert Wrapper.trim(["  before  ", "  after    "]) == ["before", "after"]
  end
end
