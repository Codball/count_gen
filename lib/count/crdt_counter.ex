defmodule Count.CRDTCounter do
  def identity do
    Node.self()
  end

  def init do
    {identity(), %{identity() => %{count: 0}}}
  end

  def increment({identity, state}) do
    %{count: count} = Map.get(state, identity)
    entry = Map.put(state, identity, %{count: count + 1})

    {identity, entry}
  end
end
