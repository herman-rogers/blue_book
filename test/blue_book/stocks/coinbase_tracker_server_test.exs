defmodule BlueBook.CoinbaseTrackerServerTest do
  use ExUnit.Case

  import Mox
  import Ecto.Query

  alias BlueBook.CoinbaseTrackerServer
  alias BlueBook.Schema.Stocks
  alias BlueBook.Repo

  setup :set_mox_from_context
  setup :verify_on_exit!

  setup do
    Mox.stub_with(BlueBook.MessengerMock, BlueBook.Messenger.Stubbed)
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BlueBook.Repo)
  end

  test "COIN stock tracker saves current price information" do
    asset_info = %{price: 42.0, symbol: "COIN", is_open: true}

    BlueBook.Services.IEXMock
    |> stub(:get_asset_information, fn _ -> {:ok, asset_info} end)

    CoinbaseTrackerServer.get_current_price()

    data =
      from(s in Stocks,
        where: s.symbol == "COIN"
      )
      |> Repo.all()

    assert length(data) == 1
  end

  test "does not save price if market is not open" do
    asset_info = %{price: 42.0, symbol: "COIN", is_open: false}

    BlueBook.Services.IEXMock
    |> stub(:get_asset_information, fn _ -> {:ok, asset_info} end)

    CoinbaseTrackerServer.get_current_price()

    data =
      from(s in Stocks,
        where: s.symbol == "COIN"
      )
      |> Repo.all()

    assert length(data) == 0
  end

  test "handles errors from api" do
    BlueBook.Services.IEXMock
    |> stub(:get_asset_information, fn _ ->
      {:error, "mock"}
    end)

    msg = CoinbaseTrackerServer.get_current_price()

    data =
      from(s in Stocks,
        where: s.symbol == "COIN"
      )
      |> Repo.all()

    assert length(data) == 0
    assert ^msg = {:error, "Error getting COIN price: mock"}
  end
end
