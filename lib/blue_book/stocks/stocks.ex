defmodule BlueBook.Schema.Stocks do
  use Ecto.Schema

  schema "stocks" do
    field :symbol, :string
    field :price, :float

    timestamps()
  end
end
