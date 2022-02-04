defmodule BlueBook.Services.External.Api do
  @callback get_asset_information(symbol :: any) :: any
end
