defmodule Topmovie.MovieInfoTest do
  use Topmovie.ModelCase

  alias Topmovie.MovieInfo

  @valid_attrs %{adult: true, backdrop_path: "some content", genres: [], id: 42, overview: "some content", popularity: "120.5", poster_path: "some content", title: "some content", video: true, vote_average: "120.5", vote_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MovieInfo.changeset(%MovieInfo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MovieInfo.changeset(%MovieInfo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
