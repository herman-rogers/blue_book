defmodule BlueBook.Services.IEX do
  @iex_url "https://cloud.iexapis.com/v1"

  @behaviour BlueBook.Services.External.Api

  @impl BlueBook.Services.External.Api
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

      {:error, %HTTPoison.Error{id: _id, reason: reason}} ->
        {:error, "Error fetching IEX data for #{symbol}: #{reason}"}
    end
  end

  def format_results(
        {:ok,
         %{"latestPrice" => latestPrice, "symbol" => symbol, "isUSMarketOpen" => isUSMarketOpen}}
      ) do
    info = %{price: latestPrice, symbol: symbol, is_open: isUSMarketOpen}

    {:ok, info}
  end

  def format_results({:error, reason}) do
    %{error: reason}
  end
end
