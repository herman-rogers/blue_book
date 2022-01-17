defmodule BlueBook.Schema.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlueBook.Schema.Transaction

  schema "addresses" do
    field :address, :string
    field :owner, :string
    field :owner_type, :string

    has_many :transactions, Transaction

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:address, :owner, :owner_type])
    |> validate_required([:address, :owner, :owner_type])
  end
end
