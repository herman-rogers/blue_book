defmodule BlueBook.AssetTracker do
  @doc """
  Get asset price information
  """
  @callback get_current_price() :: nil
end
