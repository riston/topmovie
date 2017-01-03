defmodule Topmovie.Repo.Migrations.CreateMovieInfo do
  use Ecto.Migration

  def change do
    create table(:movie_info) do
      add :imdb_id, :string
      add :title, :string
      add :overview, :string
      add :adult, :boolean, default: false, null: false
      add :video, :boolean, default: false, null: false
      add :backdrop_path, :string
      add :genres, {:array, :string}
      add :popularity, :float
      add :poster_path, :string
      add :vote_average, :float
      add :vote_count, :integer

      timestamps()
    end

  end
end
