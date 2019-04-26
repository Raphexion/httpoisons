defmodule HttpoisonsTest do
  use ExUnit.Case
  doctest Httpoisons

  test "greets the world" do
    assert Httpoisons.hello() == :world
  end
end
