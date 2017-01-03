defmodule Topmovie.Repo.Migrations.AddMovieIdRelation do
  use Ecto.Migration

  def change do
    alter table(:movie_info) do
      add :movie_id, references(:movies)
    end
  end
end
