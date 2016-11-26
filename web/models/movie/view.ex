defmodule Topmovie.Movie.View do
  use Topmovie.Web, :model

  schema "views" do
    field :view_count, :integer
    belongs_to :movie, Topmovie.Movie

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:view_count, :movie_id])
    |> validate_required([:view_count, :movie_id])
  end

  def insert(params \\ {}) do
      view = %Topmovie.Movie.View{}

      Topmovie.Movie.View.changeset(view, %{ view_count: params.view_count, movie_id: params.id })
      |> Topmovie.Repo.insert
  end

end
