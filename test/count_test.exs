defmodule CountTest do
  use ExUnit.Case
  doctest Count
  
  test "add 1 to current count" do
    current_count = Count.current_count()
    Count.increment()
    
    assert Count.current_count() == current_count + 1
  end

  test "Initial count" do
    Count.reset_count()
    current_count = Count.current_count()

    assert current_count == 0
  end


  test "reset count to 0" do
    Count.reset_count()
    current_count = Count.current_count()
    
    assert current_count == 0
  end
end
