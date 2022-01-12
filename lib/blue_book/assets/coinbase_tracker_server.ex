defmodule BlueBook.CoinbaseTrackerServer do
  @behaviour BlueBook.AssetTracker

  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

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
    IO.inspect("UPDATE COIN INFORMATION")
  end
end
