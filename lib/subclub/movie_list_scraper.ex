
defmodule Subclub.MovieListScraper do

    @base_url "http://www.subclub.eu/jutud.php"

    def start do
        1..5
        |> Enum.map(fn(page) ->
            HTTPotion.get(@base_url, query: %{sort: "uued", selected: "movies", page: page}) end)
        |> Enum.map(fn(resp) ->
           Subclub.MovieListParser.start(resp.body) end)
    end

    def insert(movie_rows) do
        movie_rows
        |> IO.inspect
        |> List.flatten
        |> Enum.map(fn(movie_row) ->
            movie = Topmovie.Movie.upsert(movie_row)
            Topmovie.Movie.View.insert(movie_row)
            movie
        end)
    end
end
