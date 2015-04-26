defmodule Conway do
  def run(initial_state_string) do
    initial_state_string
    |> String.split("\n")
    |> Enum.map(&string_to_boolean_list/1)
    |> next
    |> boolean_list_to_string
    |> Kernel.<>("\n")
  end

  def string_to_boolean_list(string) do
    string
    |> String.split("", trim: true)
    |> Enum.map(&char_to_boolean/1)
  end

  def boolean_list_to_string(list) do
    list
    |> Enum.map(
      fn row ->
        row
        |> Enum.map(&boolean_to_char/1)
        |> Enum.join
      end
    )
    |> Enum.join("\n")
  end

  def char_to_boolean("0"), do: false
  def char_to_boolean("1"), do: true

  def boolean_to_char(false), do: "0"
  def boolean_to_char(true), do: "1"

  def next(boolean_grid) do
    boolean_grid
    |> map_with_moore_neighbors(
      fn alive, neighbors ->
        alive_next(alive: alive, alive_neighbors: neighbors |> Enum.count(&(&1)))
      end
    )
  end

  def map_with_moore_neighbors(grid, fun) do
    map_with_index(grid,
      fn row, row_index ->
        map_with_index(row,
          fn elem, col_index ->
            fun.(elem, grid |> neighbors(row_index, col_index))
          end
        )
      end
    )
  end

  @neighbor_shifts [
    [-1, -1], [-1,  0], [-1,  1],
    [ 0, -1],           [ 0,  1],
    [ 1, -1], [ 1,  0], [ 1,  1],
  ]

  def neighbors(grid, row_index, col_index) do
    @neighbor_shifts
    |> Enum.map(
      fn [row_shift, col_shift] ->
        grid
        |> nonwrapping_at(row_index + row_shift, [])
        |> nonwrapping_at(col_index + col_shift)
      end
    )
    |> Enum.filter(fn x -> !is_nil x end)
  end

  def nonwrapping_at(collection, n, default \\ nil)
  def nonwrapping_at(collection, n, default) when n >= 0, do: Enum.at(collection, n, default)
  def nonwrapping_at(collection, n, default) when n < 0, do: default

  def map_with_index(collection, fun) do
    {result, _} = Enum.map_reduce(collection, 0,
      fn elem, i ->
        { fun.(elem, i), i + 1 }
      end
    )
    result
  end

  def alive_next(alive: true, alive_neighbors: 2), do: true
  def alive_next(alive: _, alive_neighbors: 3), do: true
  def alive_next(alive: _, alive_neighbors: _), do: false
end
