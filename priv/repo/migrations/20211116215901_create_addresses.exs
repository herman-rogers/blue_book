defmodule BlueBook.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :address, :string
      add :owner, :string
      add :owner_type, :string

      timestamps()
    end
  end
end
