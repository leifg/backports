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

  test "TrimWrapper returns correct output piped input" do
    assert TrimWrapper.trim_piped("  string  ") == "string"
  end

  test "TrimWrapper returns correct output for nested input" do
    assert TrimWrapper.trim_nested("  string  ") == "string"
  end

  test "TrimWrapper returns correct output for conditional input" do
    assert TrimWrapper.trim_with_condition("  string  ", 1) == "string"
  end

  test "TrimWrapper returns correct output for dealyed call" do
    assert TrimWrapper.delayed_trim("  string  ") == "string"
  end

  # trim/2

  test "TrimWrapper returns correct trim for arity 2" do
    assert TrimWrapper.trim("XXstringXX", "X") == "string"
  end
end
