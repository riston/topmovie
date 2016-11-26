defmodule Topmovie.MovieView do
  use Topmovie.Web, :view

  def get_view_label(view_count) do
      cond do
          view_count <= 500 -> "label-default"
          view_count >= 1000 -> "label-warning"
          view_count < 1000 -> "label-success"
          true -> "label-success"
      end
  end

  def first_view_count(views) do
      first = hd(views)
      { _id, view, _date } = first
      view
  end

  def get_views(views) do
      views
      |> Enum.map(fn(x) -> {_, view, _ } = x
        view end)
      |> Enum.sort
      |> Enum.join(",")
  end
end
