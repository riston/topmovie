
defmodule Mix.Tasks.Execute.MovieInfoScraper do
  use Mix.Task
  # setup so we can use Ecto in a mix task
  import Mix.Ecto

  @max_rows 25

  @shortdoc "Description of my_custom_task"

  def run(_) do
    # start the Repo for interacting with data
    ensure_started(Topmovie.Repo, [])
    {:ok, _started} = Application.ensure_all_started(:httpotion)

    IO.puts "Run movie info scraper"

    genres = to_genre_map
    |> IO.inspect

    movies = Topmovie.Movie.get_top_movies
    |> Topmovie.Repo.all
    
    movies
    |> Enum.map(&extract_id/1)
    |> Enum.take(@max_rows)
    |> Enum.map(fn(x) ->
        # Get TMDB response
        info_response = Themoviedb.Client.find_movie(x.imdb_id) 

        # Extract the Movie info object and add id 
        movie_info = get_movie_info(info_response)
        |> IO.inspect
        |> Map.put(:imdb_id, x.imdb_id)

        # Transform id's to text
        str_genres_list = 
            case movie_info.genre_ids do
                x when is_list(x) -> x
                _ -> []
            end
            |> Enum.map(fn(x) -> genres[x] end)
        
        movie_info
        |> Map.put(:genres, str_genres_list)
        |> Map.put(:movie_id, x.id)
    end)
    |> Enum.filter(fn(movie) -> movie.id != nil end)
    |> Enum.map(&insert/1)
  end

  defp extract_id(%Topmovie.Movie{ :imdb_link => nil }), do: 
    %{id: 0, imdb_id: "tt0000000"}
  defp extract_id(%Topmovie.Movie{ :id => id, :imdb_link => imdb_link }) do
    %{id: id, imdb_id: String.split(imdb_link, "/")
        |> Enum.take(-1)
        |> hd} 
  end

  defp to_genre_map do
    list = case Themoviedb.Client.list_genres do
        {:ok, %{"genres" => list}} -> list
        _ -> []
    end

    to_map = fn(x, acc) -> Map.put(acc, x.id, x.name) end
    Enum.reduce(list, %{}, to_map)
  end

  defp get_movie_info(response) do
    case response do
        {:ok, %{"movie_results" => [movie|_]}} -> movie
        {:ok, %{"movie_results" => []}} -> %Themoviedb.Movie{} 
        _ -> %Themoviedb.Movie{}
    end
  end

  defp insert(movie) do
    %{ :id => id } = movie

    case Topmovie.Repo.get(Topmovie.MovieInfo, id) do
        nil  -> %Topmovie.MovieInfo{id: id}
        info -> info
    end
    |> Topmovie.MovieInfo.changeset(Map.from_struct(movie))
    |> Topmovie.Repo.insert_or_update
  end
end
