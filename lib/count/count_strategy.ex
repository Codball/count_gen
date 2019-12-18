defmodule Count.Strategy do
  def initial_state do
    0
  end

  def increment_one(state) do
    state + 1
  end
end