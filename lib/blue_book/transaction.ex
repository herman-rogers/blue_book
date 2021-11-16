defmodule BlueBook.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlueBook.Address

  schema "transactions" do
    field :amount_usd, :integer
    field :blockchain, :string
    field :hash, :string
    field :symbol, :string
    field :transaction_type, :string

    belongs_to(:address, Address)
    embeds_one :to, Address

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:blockchain, :symbol, :transaction_type, :hash, :amount_usd])
    |> validate_required([:blockchain, :symbol, :transaction_type, :hash, :amount_usd])
  end
end
