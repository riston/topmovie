defmodule Topmovie.Router do
  use Topmovie.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Topmovie do
    pipe_through :browser # Use the default browser stack

    get "/", MovieController, :list

    resources "/views", Movie.ViewController
    resources "/movies", MovieController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Topmovie do
  #   pipe_through :api
  # end
end
