defmodule Topmovie.Repo.Migrations.ChangeToText do
  use Ecto.Migration

  def change do
    alter table(:movie_info) do
      modify :overview, :text
    end
  end
end
