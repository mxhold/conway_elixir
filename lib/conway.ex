defmodule Conway do
  def run(initial_state_string, iterations \\ 1) do
    initial_state_string
    |> StringConversion.multiline_string_to_boolean_grid
    |> next(iterations)
    |> StringConversion.boolean_grid_to_multiline_string
  end

  def next(boolean_grid, iterations) do
    Enum.reduce(
      1..iterations,
      boolean_grid,
      fn _, acc ->
        acc
        |> EnumExtended.map_with_moore_neighbors(
          fn alive, neighbors ->
            alive_next(alive: alive, alive_neighbors: neighbors |> Enum.count(&(&1)))
          end
        )
      end
    )
  end

  def alive_next(alive: true, alive_neighbors: 2), do: true
  def alive_next(alive: _, alive_neighbors: 3), do: true
  def alive_next(alive: _, alive_neighbors: _), do: false
end
