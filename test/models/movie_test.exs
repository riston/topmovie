defmodule Topmovie.MovieTest do
  use Topmovie.ModelCase

  alias Topmovie.Movie

  @valid_attrs %{author: "some content", category: [], fps: "120.5", score: "120.5", title: "some content", view_count: 42, year: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Movie.changeset(%Movie{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Movie.changeset(%Movie{}, @invalid_attrs)
    refute changeset.valid?
  end
end
