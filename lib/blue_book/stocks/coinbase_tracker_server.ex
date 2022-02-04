defmodule BlueBook.CoinbaseTrackerServer do
  alias BlueBook.AssetTracker, as: AssetTracker
  alias BlueBook.Schema.{Stocks}
  alias BlueBook.Repo

  @behaviour BlueBook.AssetTracker

  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    get_current_price()
    schedule_work()
    {:noreply, state}
  end

  def schedule_work() do
    Process.send_after(self(), :work, 1000 * 10)
  end

  @impl AssetTracker
  def get_current_price() do
    %{price: price, symbol: symbol, is_open: is_open} = iex_api().get_asset_information("COIN")

    # if error do
    #   IO.inspect(error)
    # end

    if is_open do
      stock = %Stocks{price: price, symbol: symbol}
      Repo.insert(stock)
    end
  end

  defp iex_api(), do: Application.get_env(:blue_book, :iex_api)
end
