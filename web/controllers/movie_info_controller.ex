defmodule Topmovie.MovieInfoController do
  use Topmovie.Web, :controller

  alias Topmovie.MovieInfo

  def index(conn, _params) do
    movie_info = Repo.all(MovieInfo)
    render(conn, "index.html", movie_info: movie_info)
  end

  # def new(conn, _params) do
  #   changeset = MovieInfo.changeset(%MovieInfo{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"movie_info" => movie_info_params}) do
  #   changeset = MovieInfo.changeset(%MovieInfo{}, movie_info_params)

  #   case Repo.insert(changeset) do
  #     {:ok, _movie_info} ->
  #       conn
  #       |> put_flash(:info, "Movie info created successfully.")
  #       |> redirect(to: movie_info_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   movie_info = Repo.get!(MovieInfo, id)
  #   render(conn, "show.html", movie_info: movie_info)
  # end

  # def edit(conn, %{"id" => id}) do
  #   movie_info = Repo.get!(MovieInfo, id)
  #   changeset = MovieInfo.changeset(movie_info)
  #   render(conn, "edit.html", movie_info: movie_info, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "movie_info" => movie_info_params}) do
  #   movie_info = Repo.get!(MovieInfo, id)
  #   changeset = MovieInfo.changeset(movie_info, movie_info_params)

  #   case Repo.update(changeset) do
  #     {:ok, movie_info} ->
  #       conn
  #       |> put_flash(:info, "Movie info updated successfully.")
  #       |> redirect(to: movie_info_path(conn, :show, movie_info))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", movie_info: movie_info, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   movie_info = Repo.get!(MovieInfo, id)

  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(movie_info)

  #   conn
  #   |> put_flash(:info, "Movie info deleted successfully.")
  #   |> redirect(to: movie_info_path(conn, :index))
  # end
end
