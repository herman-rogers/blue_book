defmodule BlueBook.Services.IEX do
  @iex_url "https://cloud.iexapis.com/v1"

  def get_asset_information(symbol) do
    api_key = Application.fetch_env!(:blue_book, :iex_api_key)

    IO.inspect("GETTING ASSET PRICE")
    IO.inspect(api_key)
  end
end
