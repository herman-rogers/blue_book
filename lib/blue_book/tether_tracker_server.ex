defmodule BlueBook.TetherTrackerServer do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    IO.inspect("GETTING TO HERE >>>>>>>>>>")
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    # 10 seconds
    Process.send_after(self(), :work, 1000 * 10)
  end
end
