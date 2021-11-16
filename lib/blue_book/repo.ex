defmodule BlueBook.Repo do
  use Ecto.Repo,
    otp_app: :blue_book,
    adapter: Ecto.Adapters.Postgres
end
