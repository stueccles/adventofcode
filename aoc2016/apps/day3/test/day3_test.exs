defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "nope" do
    assert Day3.valid_triangle?({10, 5, 25}) == false
  end
end
