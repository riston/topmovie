defmodule Topmovie.Movie.ViewControllerTest do
  use Topmovie.ConnCase

  alias Topmovie.Movie.View
  @valid_attrs %{view_count: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, view_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing views"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, view_path(conn, :new)
    assert html_response(conn, 200) =~ "New view"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, view_path(conn, :create), view: @valid_attrs
    assert redirected_to(conn) == view_path(conn, :index)
    assert Repo.get_by(View, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, view_path(conn, :create), view: @invalid_attrs
    assert html_response(conn, 200) =~ "New view"
  end

  test "shows chosen resource", %{conn: conn} do
    view = Repo.insert! %View{}
    conn = get conn, view_path(conn, :show, view)
    assert html_response(conn, 200) =~ "Show view"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, view_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    view = Repo.insert! %View{}
    conn = get conn, view_path(conn, :edit, view)
    assert html_response(conn, 200) =~ "Edit view"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    view = Repo.insert! %View{}
    conn = put conn, view_path(conn, :update, view), view: @valid_attrs
    assert redirected_to(conn) == view_path(conn, :show, view)
    assert Repo.get_by(View, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    view = Repo.insert! %View{}
    conn = put conn, view_path(conn, :update, view), view: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit view"
  end

  test "deletes chosen resource", %{conn: conn} do
    view = Repo.insert! %View{}
    conn = delete conn, view_path(conn, :delete, view)
    assert redirected_to(conn) == view_path(conn, :index)
    refute Repo.get(View, view.id)
  end
end
