defmodule BlueBook.Messenger.Stubbed do
  @behaviour BlueBook.Messenger

  @impl BlueBook.Messenger
  def error(message) do
    {:error, message}
  end
end
