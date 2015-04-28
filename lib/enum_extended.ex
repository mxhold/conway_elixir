defmodule EnumExtended do
  def map_with_moore_neighbors(grid, fun) do
    Enum.with_index(grid) |> Enum.map(
      fn {row, row_index} ->
        Enum.with_index(row) |> Enum.map(
          fn {elem, col_index} ->
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
end
