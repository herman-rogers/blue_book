defmodule BlueBook.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlueBook.Transaction

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
