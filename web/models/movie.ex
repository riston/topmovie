defmodule Topmovie.Movie do
  use Topmovie.Web, :model

  alias Topmovie.Movie.View

  @top_movie_count 25

  schema "movies" do
    field :title, :string
    field :year, :integer
    field :fps, :float
    field :score, :float
    field :author, :string
    field :imdb_link, :string
    field :view_count, :integer
    field :category, {:array, :string}

    has_one :info, Topmovie.MovieInfo
    has_many :views, View

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :year, :fps, :score, :author, :imdb_link, :view_count, :inserted_at, :updated_at])
    |> validate_required([:title, :year, :fps, :score, :author, :imdb_link, :view_count])
  end

  #qq
  # Topmovie.Movie.upsert(12, %{title: "A", fps: 23.0, year: 2016, score: 5.0, view_count: 100, author: "Muki" })
  def upsert(params \\ %{}) do

    params = %{ params | :inserted_at => to_ecto_datetime(params.inserted_at) }
    params = %{ params | :updated_at => to_ecto_datetime(params.updated_at) }

    case Topmovie.Repo.get(Topmovie.Movie, params.id) do
        nil -> %Topmovie.Movie{id: params.id}
        movie -> movie
    end
    |> Topmovie.Movie.changeset(params)
    |> Topmovie.Repo.insert_or_update
  end

  def get_movies do
    viewQuery = from(v in View,
        select: {v.movie_id, max(v.view_count), fragment("DATE(?)", v.inserted_at)},
        group_by: [v.movie_id, fragment("DATE(?)", v.inserted_at)],
        order_by: fragment("DATE(?)", v.inserted_at))

    get_top_movies
        |> Topmovie.Repo.all
        |> Topmovie.Repo.preload([:info, views: viewQuery])
  end

  def get_top_movies do
    from(m in Topmovie.Movie,
        where: (m.inserted_at > ago(1, "month")) 
          or (m.updated_at > ago(1, "month")),
        order_by: [desc: m.view_count],
        limit: @top_movie_count)
  end

  defp to_ecto_datetime(date) do
    date
      |> Ecto.Date.cast!
      |> Ecto.DateTime.from_date
  end
end
