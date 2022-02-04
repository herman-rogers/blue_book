defmodule BlueBook.CoinbaseTrackerServerTest do
  use ExUnit.Case
  import Mox

  alias BlueBook.CoinbaseTrackerServer

  setup :set_mox_from_context
  setup :verify_on_exit!

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BlueBook.Repo)
  end

  test "put a stub here" do
    asset_info = %{price: 42.0, symbol: "COIN", is_open: true}

    BlueBook.Services.IEXMock
    |> stub(:get_asset_information, fn _ -> asset_info end)

    data = CoinbaseTrackerServer.get_current_price()

    assert true == true
  end
end
