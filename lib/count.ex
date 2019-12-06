defmodule Count do
  alias Count.Api
  defdelegate current_count(), to: Api
end
