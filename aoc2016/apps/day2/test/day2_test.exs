defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "1st" do
    assert Day2.find_number(5, "ULL") == 1
  end

  test "2nd" do
    assert Day2.find_number(1, "RRDDD") == 9
  end

  test "3rd" do
    assert Day2.find_number(9, "LURDL") == 8
  end

  test "4th" do
    assert Day2.find_number(8, "UUUUD") == 5
  end

  test "p2 1st" do
    assert Day2Part2.find_number(5, "ULL") == 5
  end

  test "p2 2nd" do
    assert Day2Part2.find_number(5, "RRDDD") == "D"
  end

  test "p2 3rd" do
    assert Day2Part2.find_number("D", "LURDL") == "B"
  end

  test "p2 4th" do
    assert Day2Part2.find_number("B", "UUUUD") == 3
  end
end
