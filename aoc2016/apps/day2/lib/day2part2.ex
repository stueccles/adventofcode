defmodule Day2Part2 do
  @moduledoc """
  1 2 3
  4 5 6
  7 8 9

  could do this with some epic pattern matching
  """
  @filename "input.txt"

  def run do
    File.stream!(@filename)
    |> Enum.to_list
    |> Enum.reduce({[], 5}, fn(line, {list, current_number}) ->
      new_number = find_number(current_number, line)
      {list ++ [new_number], new_number}
    end)

  end

  def find_number(initial_number, instructions) do
    instructions
    |> String.graphemes
    |> Enum.reduce(initial_number, fn(d, no) -> move(no, d) end)
  end

@doc """
    1
  2 3 4
5 6 7 8 9
  A B C
    D
  """
  def move(1, "D"), do: 3
  def move(2, "D"), do: 6
  def move(2, "R"), do: 3
  def move(3, "U"), do: 1
  def move(3, "L"), do: 2
  def move(3, "D"), do: 7
  def move(3, "R"), do: 4
  def move(4, "L"), do: 3
  def move(4, "D"), do: 8
  def move(5, "R"), do: 6
  def move(6, "U"), do: 2
  def move(6, "L"), do: 5
  def move(6, "D"), do: "A"
  def move(6, "R"), do: 7
  def move(7, "L"), do: 6
  def move(7, "U"), do: 3
  def move(7, "R"), do: 8
  def move(7, "D"), do: "B"
  def move(8, "L"), do: 7
  def move(8, "U"), do: 4
  def move(8, "R"), do: 9
  def move(8, "D"), do: "C"
  def move(9, "L"), do: 8
  def move("A", "U"), do: 6
  def move("A", "R"), do: "B"
  def move("B", "U"), do: 7
  def move("B", "R"), do: "C"
  def move("B", "D"), do: "D"
  def move("B", "L"), do: "A"
  def move("C", "U"), do: 8
  def move("C", "L"), do: "B"
  def move("D", "U"), do: "B"

  def move(no, _), do: no
end
