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

  def current_count({identity, state}) do
    Enum.reduce(state, 0, fn {_node, %{count: count}}, acc ->
      count + acc
    end)
  end

  def join({identity, state}, nodes) do
    keys = (Map.keys(state) ++ Map.keys(nodes)) |> Enum.uniq() |> IO.inspect()

    values =
      Enum.map(keys, fn node ->
        count = Map.get(state, node)
        incoming_count = Map.get(nodes, node)

        value = max(count, incoming_count)

        {node, value}
      end)
      |> Map.new()

    {identity, values}
  end

  def reset({identity, state}) do

  end
end
