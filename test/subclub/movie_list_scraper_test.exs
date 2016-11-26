
defmodule Subclub.MovieListScraperTest do
  use ExUnit.Case
  doctest Topmovie

  alias Subclub.MovieListScraper, as: Scraper
  #
  # setup do
  #   html = File.read! "test/subclub/example-subclub.html"
  #   %{ html: html }
  # end

  test "parser checks" do
    #   IO.inspect Scraper.start
      assert 1 == 1
  end

end
