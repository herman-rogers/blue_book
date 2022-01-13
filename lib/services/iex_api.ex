defmodule BlueBook.Services.IEX do
  @iex_url "https://cloud.iexapis.com/v1"

  def get_asset_information(symbol) do
    symbol
    |> get_asset_data()
    |> format_results()
  end

  def get_asset_data(symbol) do
    api_key = Application.fetch_env!(:blue_book, :iex_api_key)
    url = "#{@iex_url}/stock/#{symbol}/quote?token=#{api_key}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body)}
    end
  end

  def format_results(
        {:ok,
         %{"latestPrice" => latestPrice, "symbol" => symbol, "isUSMarketOpen" => isUSMarketOpen}}
      ) do
    %{price: latestPrice, symbol: symbol, is_open: isUSMarketOpen}
  end
end
