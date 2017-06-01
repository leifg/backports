defmodule BackportsTest do
  use ExUnit.Case

  test "Wrapper returns nil value for nil input" do
    assert Wrapper.trim(nil) == nil
  end

  test "Wrapper returns correct trim" do
    assert Wrapper.trim("  before") == "before"
  end
end
