defmodule StringConversion do
  def multiline_string_to_boolean_grid(multiline_string) do
    multiline_string
    |> String.split("\n")
    |> Enum.map(&string_to_boolean_list/1)
  end

  def string_to_boolean_list(string) do
    string
    |> String.split("", trim: true)
    |> Enum.map(&char_to_boolean/1)
  end

  def boolean_grid_to_multiline_string(grid) do
    grid
    |> Enum.map(&boolean_list_to_string/1)
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  def boolean_list_to_string(list) do
    list
    |> Enum.map(&boolean_to_char/1)
    |> Enum.join
  end

  def char_to_boolean("0"), do: false
  def char_to_boolean("1"), do: true

  def boolean_to_char(false), do: "0"
  def boolean_to_char(true), do: "1"
end
