defmodule Day3 do

  @filename "input.txt"

  def run do
    File.stream!(@filename)
    |> Enum.to_list
    |> Enum.map(&String.split(&1))
    |> Enum.map(&convert(List.to_tuple(&1)))
    |> Enum.count(&valid_triangle?(&1))
  end

  def run2 do
    File.stream!(@filename)
    |> Enum.to_list
    |> Enum.map(&String.split(&1))
    |> Enum.map(&convert(List.to_tuple(&1)))
    |> Enum.chunk(3)
    |> Enum.flat_map(&column_out(&1))
    |> Enum.count(&valid_triangle?(&1))
  end

  def convert({a,b,c}) do
    {String.to_integer(a), String.to_integer(b), String.to_integer(c)}
  end

  def column_out([a,b,c]) do
    Enum.map(0..2, fn(x) -> {elem(a,x), elem(b,x), elem(c,x)} end)
  end

  def valid_triangle?({a, b, c}) do
    valid?(a,b,c) && valid?(a,c,b) && valid?(c,b,a)
  end

  defp valid?(first, second, third), do: first + second > third
end
