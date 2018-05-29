defmodule SmgTest do
  use ExUnit.Case
  doctest Smg

  test "greets the world" do
    assert Smg.hello() == :world
  end
end
