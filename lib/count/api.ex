defmodule Count.Api do
  def current_count() do
    GenServer.call(Count.Worker, :current_count)
  end

  def reset_count() do
    GenServer.call(Count.Worker, :reset_count)
  end

  def increment() do
    GenServer.cast(Count.Worker, :increment)
  end
end