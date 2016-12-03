defmodule Day1 do
  @moduledoc """
  starting at 0,0 modify the co-ordinates by rotating and moving blocks
  need a three tuple state = {{x, y}, {xv, yv}}
  initial state = {{0, 0}, {0, 1}}
  """
  @input ["R3", "L5", "R2", "L1", "L2", "R5", "L2", "R2", "L2", "L2", "L1", "R2", "L2", "R4", "R4", "R1", "L2", "L3", "R3", "L1", "R2", "L2", "L4", "R4", "R5", "L3", "R3", "L3", "L3", "R4", "R5", "L3", "R3", "L5", "L1", "L2", "R2", "L1", "R3", "R1", "L1", "R187", "L1", "R2", "R47", "L5", "L1", "L2", "R4", "R3", "L3", "R3", "R4", "R1", "R3", "L1", "L4", "L1", "R2", "L1", "R4", "R5", "L1", "R77", "L5", "L4", "R3", "L2", "R4", "R5", "R5", "L2", "L2", "R2", "R5", "L2", "R194", "R5", "L2", "R4", "L5", "L4", "L2", "R5", "L3", "L2", "L5", "R5", "R2", "L3", "R3", "R1", "L4", "R2", "L1", "R5", "L1", "R5", "L1", "L1", "R3", "L1", "R5", "R2", "R5", "R5", "L4", "L5", "L5", "L5", "R3", "L2", "L5", "L4", "R3", "R1", "R1", "R4", "L2", "L4", "R5", "R5", "R4", "L2", "L2", "R5", "R5", "L5", "L2", "R4", "R4", "L4", "R1", "L3", "R1", "L1", "L1", "L1", "L4", "R5", "R4", "L4", "L4", "R5", "R3", "L2", "L2", "R3", "R1", "R4", "L3", "R1", "L4", "R3", "L3", "L2", "R2", "R2", "R2", "L1", "L4", "R3", "R2", "R2", "L3", "R2", "L3", "L2", "R4", "L2", "R3", "L4", "R5", "R4", "R1", "R5", "R3"]
  
  @initial_state {{0, 0}, {0, 1}}

  def run(input) do
    Enum.reduce(input, @initial_state, fn(i, acc) ->
      update_state(acc, i)
    end)
  end

  def run(input, initial_state) do
    Enum.reduce(input, initial_state, fn(i, acc) ->
      update_state(acc, i)
    end)
  end

  def run1 do
    Enum.reduce(@input, @initial_state, fn(instruction, acc) ->
      update_state(acc, instruction)
    end)
  end

  def run2 do
    Enum.reduce_while(@input, {[@initial_state], @initial_state}, fn(instruction, {list, state}) ->
      <<rotate::bytes-size(1)>> <> count = instruction
      all_locations = Enum.map(1..String.to_integer(count), fn(c) ->
        update_state(state, rotate, c)
      end)

      crossing_location = Enum.find(list, fn(p1) ->
        Enum.any?(all_locations, fn(p2) -> matching_location(p1,p2) end)
      end)

      if crossing_location do
        {:halt, crossing_location}
      else
        {:cont, {list ++ all_locations, update_state(state, instruction)}}
      end
    end)
  end

  def matching_location({{x,y}, _dir1}, {{x,y}, _dir2}), do: true
  def matching_location(_,_), do: false

  def update_state({coords,direction}, <<rotate::bytes-size(1)>> <> count) do
    update_state({coords,direction}, rotate, String.to_integer(count))
  end

  def update_state({coords,direction}, rotate, count) do
    new_dir = turn(rotate, direction)
    {move(coords, new_dir, count), new_dir}
  end

  def move({x,y},{xv, yv}, count), do: {x+(xv*count), y+(yv*count)}

  def turn("R", {1, 0}), do: {0, -1}
  def turn("R", {0, -1}), do: {-1, 0}
  def turn("R", {-1, 0}), do: {0, 1}
  def turn("R", {0, 1}), do: {1, 0}

  def turn("L", {1, 0}), do: {0, 1}
  def turn("L", {0, 1}), do: {-1, 0}
  def turn("L", {-1, 0}), do: {0, -1}
  def turn("L", {0, -1}), do: {1, 0}

end
