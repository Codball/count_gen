defmodule Count do
  alias Count.Api
  defdelegate current_count(), to: Api
  defdelegate increment(), to: Api
  defdelegate reset_count(), to: Api
end
