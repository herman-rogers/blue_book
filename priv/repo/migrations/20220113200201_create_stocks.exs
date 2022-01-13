defmodule BlueBook.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :symbol, :string
      add :price, :float

      timestamps()
    end
  end
end
