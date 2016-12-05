defmodule Day4 do
  @moduledoc """
  aaaaa-bbb-z-y-x-123[abxyz]
  (\D*)(\d*)(\[.*\])
  """

  @filename "input.txt"

  def run do
    File.stream!(@filename)
    |> Enum.to_list
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&parse_room(&1))
    |> Enum.map(&score(&1))
    |> Enum.reduce(0, fn(s, acc) -> acc + s end)
  end

  def run2 do
    File.stream!(@filename)
    |> Enum.to_list
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&parse_room(&1))
    |> Enum.filter(&valid?(&1))
    |> Enum.map(fn(r) -> {decode(r),elem(r,2)} end)
    |> IO.inspect(limit: 34343434)
  end

  def parse_room(encypted_string) do
    Regex.scan(~r/(\D*)(\d*)(\[.*\])/, encypted_string)
    |> List.first
    |> List.to_tuple
  end

  def score({_encypted_string, code, sector, "[" <> <<checksum::bytes-size(5)>> <> "]"}) do
    count_score(valid?(code, checksum), String.to_integer(sector))
  end

  def valid?({_encypted_string, code, sector, "[" <> <<checksum::bytes-size(5)>> <> "]"}) do
    valid?(code, checksum)
  end

  def valid?(code, checksum) do
    create_checksum(code) == String.graphemes(checksum)
  end

  defp count_score(true, sector), do: sector
  defp count_score(false, _sector), do: 0

  def decode({_encypted_string, code, sector, _checksum}) do
    code
    |> String.split("-")
    |> Enum.map(&decode_word(&1, String.to_integer(sector)))
    |> Enum.join(" ")
  end

  def decode_word(word, sector) do
    word
    |> String.graphemes
    |> Enum.map(fn(c)-> Enum.reduce(1..sector, c, fn(_x, acc) -> shift(acc) end) end)
    |> Enum.join
  end

  def create_checksum(string) do
    string
    |> String.graphemes
    |> Enum.group_by(&(&1))
    |> Enum.map(fn ({k, list}) -> {k, length(list)}end)
    |> Enum.into(%{})
    |> Map.delete("-")
    |> Enum.sort(fn (e1,e2) -> sorter(e1,e2)end)
    |> Enum.take(5)
    |> Enum.map(fn ({k,v}) -> k end)
  end

  defp sorter({k1,v1},{k2,v1}), do: k1 < k2
  defp sorter({_k1,v1},{_k2,v2}), do: v1 > v2

  def shift("z"), do: "a"
  def shift(<<ch::utf8>>) do
    r = ch + 1
    << r :: utf8 >>
  end


end
