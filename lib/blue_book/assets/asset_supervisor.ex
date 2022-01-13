defmodule BlueBook.Assets.AssetSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    children = [
      {Task.Supervisor, name: Assets.TaskSupervisor},
      BlueBook.CoinbaseTrackerServer
      # BlueBook.TetherTrackerServer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
