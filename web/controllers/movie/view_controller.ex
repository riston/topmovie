defmodule Topmovie.Movie.ViewController do
  # use Topmovie.Web, :controller
  #
  # alias Topmovie.Movie.View
  #
  # def index(conn, _params) do
  #   views = Repo.all(View)
  #   render(conn, "index.html", views: views)
  # end

  # def new(conn, _params) do
  #   changeset = View.changeset(%View{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"view" => view_params}) do
  #   changeset = View.changeset(%View{}, view_params)
  #
  #   case Repo.insert(changeset) do
  #     {:ok, _view} ->
  #       conn
  #       |> put_flash(:info, "View created successfully.")
  #       |> redirect(to: view_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   view = Repo.get!(View, id)
  #   render(conn, "show.html", view: view)
  # end

  # def edit(conn, %{"id" => id}) do
  #   view = Repo.get!(View, id)
  #   changeset = View.changeset(view)
  #   render(conn, "edit.html", view: view, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "view" => view_params}) do
  #   view = Repo.get!(View, id)
  #   changeset = View.changeset(view, view_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, view} ->
  #       conn
  #       |> put_flash(:info, "View updated successfully.")
  #       |> redirect(to: view_path(conn, :show, view))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", view: view, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   view = Repo.get!(View, id)
  #
  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(view)
  #
  #   conn
  #   |> put_flash(:info, "View deleted successfully.")
  #   |> redirect(to: view_path(conn, :index))
  # end
end
