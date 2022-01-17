defmodule BlueBook.Services.EtherscanApi do
  def address_txs(address) do
    url = "https://api.etherscan.io/api"

    headers = []

    options = [
      params: [
        module: "account",
        action: "txlist",
        address: address,
        startblock: 0,
        endblock: 99_999_999,
        page: 1,
        offset: 5,
        sort: "desc",
        apikey: "I6N512UAS1SF5GYFX6TER4ZNAJ9IQMCJ3R"
      ]
    ]

    process_request(url, headers, options)
  end

  defp process_request(url, headers, options) do
    case HTTPoison.get(url, headers, options) do
      {:ok, response} ->
        handle_response(response)

      _ ->
        raise "Unhandled response"
    end
  end

  defp handle_response(response) do
    case Jason.decode(response.body) do
      {:ok, %{"result" => result}} ->
        Enum.map(result, fn a -> Map.get(a, "hash") end)
    end
  end
end
