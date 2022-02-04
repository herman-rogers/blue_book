defmodule BlueBook.Messenger.App do
  require Logger

  @behaviour BlueBook.Messenger

  @impl BlueBook.Messenger
  def error(message) do
    Logger.error(message)
  end
end
