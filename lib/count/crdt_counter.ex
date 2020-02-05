defmodule Count.CRDTCounter do
  def identity do
    Node.self()
  end

  def init do
    {identity(), %{identity() => %{count: 0, version: 1}}}
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
    keys = (Map.keys(state) ++ Map.keys(nodes)) |> Enum.uniq()

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

  def reset({identity, state}, number) do
    %{version: version} = Map.get(state, identity)

    reset =
      Enum.map(state, fn {node, %{version: version} = count} ->
        if node != identity do
          {node, %{count: 0, version: version + 1}}
        else
          {node, count}
        end
      end)
      |> Map.new()

    new_state = Map.put(reset, identity, %{count: number, version: version + 1})
    {identity, new_state}
  end
end
