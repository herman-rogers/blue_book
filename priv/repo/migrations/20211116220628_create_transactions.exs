defmodule BlueBook.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :blockchain, :string
      add :symbol, :string
      add :transaction_type, :string
      add :hash, :string
      add :amount_usd, :integer

      timestamps()
    end
  end
end
