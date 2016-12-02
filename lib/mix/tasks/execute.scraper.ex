
defmodule Mix.Tasks.Execute.Scraper do
  use Mix.Task
  # setup so we can use Ecto in a mix task
  import Mix.Ecto

  @shortdoc "Description of my_custom_task"

  def run(_) do
    # start the Repo for interacting with data
    ensure_started(Topmovie.Repo, [])
    {:ok, _started} = Application.ensure_all_started(:httpotion)

    IO.puts "Run my custom mix task"
    Subclub.MovieListScraper.start()
    |> Subclub.MovieListScraper.insert
  end

end
