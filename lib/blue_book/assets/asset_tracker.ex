defmodule BlueBook.AssetTracker do
  @doc """
  This module provides a simple interface for tracking assets.
  """

  @doc """
  Get current price information for asset
  """
  @callback get_current_price() :: nil

end
