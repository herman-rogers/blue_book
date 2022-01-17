defmodule BlueBook.TetherTrackerServer do
  alias BlueBook.AssetTracker, as: AssetTracker

  @behaviour AssetTracker

  use GenServer
  alias BlueBook.Services.EtherscanApi
  alias BlueBook.Services.WhaleAlertApi
  alias BlueBook.Address

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
    IO.inspect("UPDATE TETHER INFORMATION")

    tether_treasury_address = "0x5754284f345afc66a98fbB0a0Afe71e0F007B949"

    txs = EtherscanApi.address_txs(tether_treasury_address)
    data = WhaleAlertApi.txs_data_from_hash(Enum.at(txs, 0))

    %{"from" => from} = Enum.at(data, 0)

    from_address = %Address{
      address: Map.fetch(from, :address),
      owner: Map.fetch(from, :owner),
      owner_type: Map.fetch(from, :owner_type)
    }

    Repo.insert!(from_address)

    IO.inspect("TXS >>>>>>>>>>")
    # IO.inspect(Enum.at(txs, 0))
    IO.inspect(from)
  end
end
