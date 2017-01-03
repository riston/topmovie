defmodule Topmovie.MovieInfo do
  use Topmovie.Web, :model

  schema "movie_info" do
    field :imdb_id, :string
    field :title, :string
    field :overview, :string
    field :adult, :boolean, default: false
    field :video, :boolean, default: false
    field :backdrop_path, :string
    field :genres, {:array, :string}
    field :popularity, :float
    field :poster_path, :string
    field :vote_average, :float
    field :vote_count, :integer
    belongs_to :movie, Topmovie.Movie

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:imdb_id, :title, :overview, :adult, :video, :backdrop_path, :genres, :popularity, :poster_path, :vote_average, :vote_count, :movie_id])
    |> validate_required([:imdb_id, :title, :overview, :adult, :video, :genres, :popularity, :vote_average, :vote_count, :movie_id])
  end
end
