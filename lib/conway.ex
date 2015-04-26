defmodule Conway do
  def run(initial_state_string, iterations \\ 1) do
    initial_state_string
    |> StringConversion.multiline_string_to_boolean_grid
    |> next(iterations)
    |> StringConversion.boolean_grid_to_multiline_string
  end

  def next(boolean_grid, 1) do
    boolean_grid
    |> EnumExtended.map_with_moore_neighbors(
      fn is_alive, neighbors ->
        alive_next(
          is_alive: is_alive,
          alive_neighbors: neighbors |> Enum.count(&(&1))
        )
      end
    )
  end

  def next(boolean_grid, iterations) do
    next(next(boolean_grid, iterations - 1), 1)
  end

  def alive_next(is_alive: true, alive_neighbors: 2), do: true
  def alive_next(is_alive: _, alive_neighbors: 3), do: true
  def alive_next(is_alive: _, alive_neighbors: _), do: false
end
