defmodule BlueBook.Messenger do
  @callback error(message :: binary()) :: any()
end
