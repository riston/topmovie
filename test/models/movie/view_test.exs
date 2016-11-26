defmodule Topmovie.Movie.ViewTest do
  use Topmovie.ModelCase

  alias Topmovie.Movie.View

  @valid_attrs %{view_count: 42, movie_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = View.changeset(%View{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = View.changeset(%View{}, @invalid_attrs)
    refute changeset.valid?
  end
end
