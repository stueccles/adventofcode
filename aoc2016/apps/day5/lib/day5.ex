defmodule Day5 do
  alias Experimental.Flow

  @input "wtnhxymk"

  def run do
     Stream.iterate(0, &(&1+1))
     |> Flow.from_enumerable()
     |> Flow.map(&md5_it(&1,@input))
     |> Flow.map(&match/1)
     |> Flow.filter(fn(s)-> is_binary(s) end)
     |> Enum.take(8)
  end

  def md5_it(integer, input) do
    string = input <> Integer.to_string(integer)
    Base.encode16(:erlang.md5(string), case: :lower)
  end

  def match("00000" <> <<code::bytes-size(1)>> <> <<rem::bytes-size(26)>>), do: code
  def match(_), do: false

end
