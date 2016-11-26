defmodule Topmovie.PageController do
  use Topmovie.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
