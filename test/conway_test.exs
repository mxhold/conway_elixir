defmodule ConwayTest do
  use ExUnit.Case

  test "simple blinker" do
    assert Conway.run("010\n010\n010") == "000\n111\n000\n"
  end

  test "two iterations" do
    assert Conway.run("010\n010\n010", 2) == "010\n010\n010\n"
  end
end
