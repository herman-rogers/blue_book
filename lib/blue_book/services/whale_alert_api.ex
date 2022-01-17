defmodule BlueBook.Services.WhaleAlertApi do
  def txs_data_from_hash(tx_hash) do
    url = "https://api.whale-alert.io/v1/transaction/ethereum/#{tx_hash}"

    headers = []

    options = [
      params: [
        api_key: "fSjxxabVasqIgzHAa7MjOLfzLP7IzJJB"
      ]
    ]

    process_request(url, headers, options)
  end

  defp process_request(url, headers, options) do
    # :hackney_trace.enable(:max, :io)

    case HTTPoison.get(url, headers, options) do
      {:ok, response} ->
        handle_response(response)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp handle_response(response) do
    case Jason.decode(response.body) do
      {:ok, %{"transactions" => transactions}} -> transactions
    end
  end
end
