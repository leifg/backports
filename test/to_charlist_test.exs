defmodule ToCharlistTest do
  use ExUnit.Case

  # to_charlist/1

  test "ToCharlist returns correct charlist" do
    assert ToCharlistWrapper.to_charlist("abcde") == 'abcde'
  end
end
