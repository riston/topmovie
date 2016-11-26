defmodule Topmovie.Repo.Migrations.AddImdbLink do
  use Ecto.Migration

  def change do
    alter table(:movies) do
        add :imdb_link, :string
    end
  end
end
