
defmodule MovieListParserTest do
  use ExUnit.Case
  doctest Topmovie

  alias Subclub.MovieListParser, as: Parser

  setup do
    html = File.read! "test/subclub/example-subclub.html"
    %{ html: html }
  end

  test "parser checks", %{ html: html } do
    list = Parser.start html
    first = Enum.at(list, 0)

    assert first.id === 16800
    assert first.title === "Star Trek Beyond"
    assert first.year === 2016
    assert first.fps === 23.0
    assert first.score === 5.0
    assert first.author === "Odddude"
    assert first.view_count === 462
    assert first.imdb_link === "http://us.imdb.com/title/tt2660888"
    assert first.created_at === ~D[2016-11-10]
    assert first.modified_at === ~D[2016-11-10]
  end

  test "year parsing" do
    assert Parser.year_default_parse("1967") == 1967
    assert Parser.year_default_parse("(1967)") == 1967
    assert Parser.year_default_parse("sadas2009a)") == 2009

    assert Parser.year_default_parse("asdas") == 1900
  end

  test "date string parsing" do
      assert Parser.date_parse("12.12.2003") === {:ok, ~D[2003-12-12]}
      assert Parser.date_parse("01.12.2015") === {:ok, ~D[2015-12-01]}
      assert Parser.date_parse("01.20.2015") === {:error, :invalid_date}
  end
end
