
defmodule Subclub.MovieListScraper do

    @base_url "http://www.subclub.eu/jutud.php"

    def start do
        1..2
        |> Enum.map(fn(page) ->
            HTTPotion.get(@base_url, query: %{sort: "uued", selected: "movies", page: page}) end)
        # |> Enum.map(fn(resp) ->
        #     File.write!("./test.txt", resp.body) end)
       |> Enum.map(fn(resp) ->
           Subclub.MovieListParser.start(resp.body) end)
    end

    def insert(movie_rows) do
        movie_rows
        |> List.flatten
        |> Enum.map(fn(movie_row) ->
            Topmovie.Movie.upsert(movie_row)
            Topmovie.Movie.View.insert(movie_row)
        end)
    end
end
