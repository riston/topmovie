
defmodule ClientTest do
  use ExUnit.Case
  @imdb_movie_id "tt0319343"

  test "client is working or not" do
    {:ok, %{"movie_results" => [movie|_]}} = 
      Themoviedb.Client.find_movie(@imdb_movie_id)

    assert movie.title === "Elf"
    assert movie.genre_ids === [10749, 35, 10751, 14]
  end

  test "get the genres list" do
    {:ok, %{"genres" => list}} = Themoviedb.Client.list_genres

    result = Enum.any?(list, 
      fn(x) -> x.id === 28 and x.name === "Action" end)

    assert result === true
  end
end
