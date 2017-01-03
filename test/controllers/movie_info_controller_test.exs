defmodule Topmovie.MovieInfoControllerTest do
  use Topmovie.ConnCase

  alias Topmovie.MovieInfo
  @valid_attrs %{adult: true, backdrop_path: "some content", genres: [], id: 42, overview: "some content", popularity: "120.5", poster_path: "some content", title: "some content", video: true, vote_average: "120.5", vote_count: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, movie_info_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing movie info"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, movie_info_path(conn, :new)
    assert html_response(conn, 200) =~ "New movie info"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, movie_info_path(conn, :create), movie_info: @valid_attrs
    assert redirected_to(conn) == movie_info_path(conn, :index)
    assert Repo.get_by(MovieInfo, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, movie_info_path(conn, :create), movie_info: @invalid_attrs
    assert html_response(conn, 200) =~ "New movie info"
  end

  test "shows chosen resource", %{conn: conn} do
    movie_info = Repo.insert! %MovieInfo{}
    conn = get conn, movie_info_path(conn, :show, movie_info)
    assert html_response(conn, 200) =~ "Show movie info"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, movie_info_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    movie_info = Repo.insert! %MovieInfo{}
    conn = get conn, movie_info_path(conn, :edit, movie_info)
    assert html_response(conn, 200) =~ "Edit movie info"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    movie_info = Repo.insert! %MovieInfo{}
    conn = put conn, movie_info_path(conn, :update, movie_info), movie_info: @valid_attrs
    assert redirected_to(conn) == movie_info_path(conn, :show, movie_info)
    assert Repo.get_by(MovieInfo, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    movie_info = Repo.insert! %MovieInfo{}
    conn = put conn, movie_info_path(conn, :update, movie_info), movie_info: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit movie info"
  end

  test "deletes chosen resource", %{conn: conn} do
    movie_info = Repo.insert! %MovieInfo{}
    conn = delete conn, movie_info_path(conn, :delete, movie_info)
    assert redirected_to(conn) == movie_info_path(conn, :index)
    refute Repo.get(MovieInfo, movie_info.id)
  end
end
