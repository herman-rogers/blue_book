defmodule BlueBook.Repo.Migrations.TransactionBelongsToAddress do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :address_id, references(:addresses)
    end
  end
end
