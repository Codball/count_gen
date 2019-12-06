defmodule CountTest do
  use ExUnit.Case
  doctest Count

  test "Initial count" do
    current_count = Count.current_count()
    assert current_count == 0
  end
end
