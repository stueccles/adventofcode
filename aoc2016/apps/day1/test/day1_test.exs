defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "1 input" do
    input = ["R8"]
    assert Day1.run(input) == {{8,0},{1,0}}
  end

  test "2 input" do
    input = ["R8", "R4"]
    assert Day1.run(input) == {{8,-4},{0,-1}}
  end

  test "3 input" do
    input = ["R8", "R4", "R4"]
    assert Day1.run(input) == {{4,-4},{-1,0}}
  end

  test "4 input" do
    input = ["R8", "R4", "R4", "R8"]
    assert Day1.run(input) == {{4,4},{0,1}}
  end

  test "12 blocks away" do
    input = ["R5", "L5", "R5", "R3"]
    assert Day1.run(input) == {{10,2},{0,-1}}
  end
end
