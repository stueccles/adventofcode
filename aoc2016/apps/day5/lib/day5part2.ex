defmodule Day5Part2 do
  alias Experimental.Flow

  @input "wtnhxymk"
  @blank "________"

  def run do
     Stream.iterate(0, &(&1+1))
     |> Flow.from_enumerable()
     |> Flow.map(&md5_it(&1,@input))
     |> Flow.map(&match(&1))
     |> Flow.filter(fn(s)-> is_map(s) end)
     |> Flow.partition(key: {:elem, 0}, stages: 8)
     |> Flow.reduce(fn -> String.graphemes(@blank) end, fn({pos,code}, list) ->
      if Enum.at(list, pos) == "_" do
        List.replace_at(list, pos, code)
      else
        list
      end
     end)
     |> Flow.emit(:events)
     |> Enum.take(8)
  end

  def md5_it(integer, input) do
    string = input <> Integer.to_string(integer)
    Base.encode16(:erlang.md5(string), case: :lower)
  end

  def match("00000" <> <<pos::bytes-size(1)>> <> <<code::bytes-size(1)>> <> <<rem::bytes-size(25)>>) do
    try do
      if String.to_integer(pos) < 8 do
        {pos, code}
      else
        false
      end
    rescue
      e in ArgumentError -> false
    end
  end

  def match(_), do: false

end
