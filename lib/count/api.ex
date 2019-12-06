defmodule Count.Api do
  def current_count() do
    GenServer.call(Count.Worker, :current_count)
  end
end