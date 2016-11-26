defmodule Topmovie.Repo.Migrations.CreateMovie.View do
  use Ecto.Migration

  def change do
    create table(:views) do
      add :view_count, :integer
      add :movie_id, references(:movies, on_delete: :nothing)

      timestamps()
    end
    create index(:views, [:movie_id])

  end
end
