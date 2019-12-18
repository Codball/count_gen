defmodule Count.Worker do
  use GenServer

  alias Count.Strategy

  def init(_args) do
    {:ok, Strategy.initial_state()}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def handle_call(:current_count, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:reset_count, _from, state) do
    {:reply, state, Strategy.initial_state()}
  end

  def handle_cast(:increment, state) do
    {:noreply, Strategy.increment_one(state)}
  end
end