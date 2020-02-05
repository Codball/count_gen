defmodule CountRDTCounterTest do
  use ExUnit.Case

  test "identity" do
    identity = Node.self()
    assert Count.CRDTCounter.identity() == identity
  end

  test "init" do
    init = {Count.CRDTCounter.identity(), %{Count.CRDTCounter.identity() => %{count: 0, version: 1}}}
    assert Count.CRDTCounter.init() == init
  end

  test "increment self" do
    expected = {Count.CRDTCounter.identity(), %{Count.CRDTCounter.identity() => %{count: 1}}}

    result =
      Count.CRDTCounter.init()
      |> Count.CRDTCounter.increment()

    assert result == expected
  end

  test "increment self with multiple nodes" do
    init =
      {Count.CRDTCounter.identity(),
       %{
         Count.CRDTCounter.identity() => %{count: 0},
         :node2 => %{count: 0}
       }}

    expected =
      {Count.CRDTCounter.identity(),
       %{
         Count.CRDTCounter.identity() => %{count: 1},
         :node2 => %{count: 0}
       }}

    result =
      init
      |> Count.CRDTCounter.increment()

    assert result == expected
  end

  test "current count" do
    init =
      {Count.CRDTCounter.identity(),
       %{
         Count.CRDTCounter.identity() => %{count: 2},
         :nathan => %{count: 4},
         :rj => %{count: 6},
         :node4 => %{count: 8}
       }}

    assert Count.CRDTCounter.current_count(init) == 20
  end

  test "update current node with other node value" do
    init =
      {Count.CRDTCounter.identity(),
       %{
         Count.CRDTCounter.identity() => %{count: 2},
         :node2 => %{count: 10}
       }}

    nodes = %{
      Count.CRDTCounter.identity() => %{count: 0},
      :node2 => %{count: 4},
      :node3 => %{count: 6}
    }

    node = Count.CRDTCounter.join(init, nodes)

    assert Count.CRDTCounter.current_count(node) == 18
  end

  test "reset" do
    init =
      {Count.CRDTCounter.identity(),
       %{
         Count.CRDTCounter.identity() => %{count: 2, version: 1},
         :node2 => %{count: 10, version: 1},
         :node3 => %{count: 90, version: 1},
         :node4 => %{count: 42, version: 1}
       }}

    node = Count.CRDTCounter.reset(init, 10)

    assert Count.CRDTCounter.current_count(node) == 10
  end
end
