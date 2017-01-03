defmodule Topmovie.MovieView do
  use Topmovie.Web, :view

  @new_views_count 3

  def get_view_label(view_count) do
      cond do
          view_count <= 500 -> "label-default"
          view_count >= 1000 -> "label-warning"
          view_count < 1000 -> "label-success"
          true -> "label-success"
      end
  end

  def first_view_count([]), do: 0
  def first_view_count(views) do
      first = hd(views)
      { _id, view, _date } = first
      view
  end

  def get_views(views) do
      views
      |> Enum.map(fn(x) -> {_, view, _ } = x
        view end)
      |> Enum.sort
      |> Enum.join(",")
  end

  def format_date(datetime) do
      datetime
      |> Ecto.DateTime.to_erl
      |> Timex.format!("{relative}", :relative)
  end

  def is_new(views) do
       Enum.count(views) <= @new_views_count
  end

  def render("movies.json", %{movies: movies}) do
      movies
      |> Enum.map(fn(movie) -> 
          %{
              title: movie.title,
              year: movie.year,
              score: movie.score,
              author: movie.author,
              imdb: movie.imdb_link,
              view_count: movie.view_count,
              category: movie.category || [],
              is_new: is_new(movie.views),
              created_at: Ecto.DateTime.to_string(movie.inserted_at),
              modified_at: Ecto.DateTime.to_string(movie.updated_at),
              views: render_many(movie.views, __MODULE__, "movies_views.json", as: :view)
          }
      end)
  end

  def render("movies_views.json", %{view: view}) do
    {view_count, date} = view
    date_str = case Date.from_erl(date) do
        {:ok, dt} -> Date.to_string(dt)
        _ -> "1900-01-01"
    end

    %{
        count: view_count,
        created_at: date_str
    }
  end

  def img_full_url(size, file_path) do
      "https://image.tmdb.org/t/p/#{size}/#{file_path}"
  end
end
