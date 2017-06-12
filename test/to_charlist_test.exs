defmodule ToCharlistTest do
  use ExUnit.Case

  # to_charlist/1

  test "ToCharlist returns correct charlist" do
    assert ToCharlistWrapper.to_charlist("abcde") == 'abcde'
  end

  test "ToCharlist returns correct charlist tuple (2 elements)" do
    assert ToCharlistWrapper.to_charlist_tuple_2("abcde") == {'abcde', 'abcde'}
  end

  test "ToCharlist returns correct charlist tuple (2 with array)" do
    assert ToCharlistWrapper.to_charlist_tuple_2_with_array("abcde") == {'abcde', ["a", "b"]}
  end

  test "ToCharlist returns correct charlist tuple (3 elements)" do
    assert ToCharlistWrapper.to_charlist_tuple_3("abcde") == {'abcde', 'abcde', 'abcde'}
  end
end
