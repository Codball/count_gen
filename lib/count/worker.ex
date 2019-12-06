defmodule Count.Worker do
  use GenServer

  def init(_args) do
    {:ok, 0}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def handle_call(:current_count, _from, state) do
    {:reply, state, state}
  end
end