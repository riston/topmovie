
defmodule Themoviedb.Genre do
    @derive [Poison.Encoder]
    defstruct [:id, :name]
end

defmodule Themoviedb.Movie do
    @derive [Poison.Encoder]
    defstruct [
        :id, :imdb_id, :adult, :title, :vote_count, :vote_average, 
        :poster_path, :overview, :release_date, :genre_ids,
        :original_title, {:backdrop_path, ""}, :popularity, :video
    ]
end

defmodule Themoviedb.Client do
    use HTTPotion.Base

    @api_key Application.get_env(:topmovie, :tmdb_api_key)

    def process_options(options) do
        options
        |> append_api_key
    end

    def process_url(url) do
        "https://api.themoviedb.org/3" <> url
    end

    def list_genres do
        get("/genre/movie/list", [query: %{}])
        |> process_genres
    end

    def find_movie(id) do
        get("/find/" <> id, [query: %{ "external_source": "imdb_id" }])
        |> process_movie
    end

    defp process_genres(%{status_code: 200, body: body}) do
        body
        |> to_string
        |> Poison.decode(as: %{"genres" => [%Themoviedb.Genre{}]})
    end
    defp process_genres(%HTTPotion.ErrorResponse{}) do 
        {:error, %{"genres" => [%Themoviedb.Genre{}]}}
    end

    defp process_movie(%{status_code: 200, body: body}) do
        body
        |> to_string
        |> Poison.decode(as: %{"movie_results" => [%Themoviedb.Movie{}]})
    end
    defp process_movie(%HTTPotion.ErrorResponse{}) do
        {:error, %{"movie_results" => [%Themoviedb.Movie{}]}}
    end
    
    defp append_api_key(options) do
        options
        |> Keyword.put(:query, 
            Map.put(options[:query] || [], :api_key, @api_key))
    end
end