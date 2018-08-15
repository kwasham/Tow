defmodule TimesofwarTest do
  use ExUnit.Case
  doctest Timesofwar

  test "greets the world" do
    assert Timesofwar.hello() == :world
  end
end
