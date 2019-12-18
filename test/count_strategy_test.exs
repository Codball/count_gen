defmodule CountStrategyTest do
  use ExUnit.Case
  doctest Count

  alias Count.Strategy
  
  test "add 1" do
    assert Strategy.increment_one(0) == 1
  end

  test "Initial count" do
    assert Strategy.initial_state() == 0
  end
end