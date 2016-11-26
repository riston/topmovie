defmodule Topmovie.Repo.Migrations.CreateMovie do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :year, :integer
      add :fps, :float
      add :score, :float
      add :author, :string
      add :view_count, :integer
      add :category, {:array, :string}

      timestamps()
    end

  end
end
