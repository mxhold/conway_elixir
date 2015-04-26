defmodule EnumExtended do
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

  def neighbors(grid, row_index, col_index) do
    [
      [-1, -1], [-1,  0], [-1,  1],
      [ 0, -1],           [ 0,  1],
      [ 1, -1], [ 1,  0], [ 1,  1],
    ]
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
  def nonwrapping_at(_collection, n, default) when n < 0, do: default

  def map_with_index(collection, fun) do
    {result, _} = Enum.map_reduce(collection, 0,
      fn elem, i ->
        { fun.(elem, i), i + 1 }
      end
    )
    result
  end
end
