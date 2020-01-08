defmodule CountRDTCounterTest do
  use ExUnit.Case

  test "identity" do
    identity = Node.self()
    assert Count.CRDTCounter.identity() == identity
  end

  test "init" do
    init = {Count.CRDTCounter.identity(), %{Count.CRDTCounter.identity() => %{count: 0}}}
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
end
