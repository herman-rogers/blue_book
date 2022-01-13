defmodule BlueBook.Services.IEX do
  @iex_url "https://cloud.iexapis.com/v1"

  def get_asset_information(symbol) do
    api_key = Application.fetch_env!(:blue_book, :iex_api_key)

    # req = 'https://cloud.iexapis.com/stable/stock/aapl/quote?token=YOUR_TOKEN_HERE'

    url = "#{@iex_url}/stock/#{symbol}/quote?token=#{api_key}"

    IO.inspect("GETTING ASSET PRICE")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body)}
    end
  end
end
