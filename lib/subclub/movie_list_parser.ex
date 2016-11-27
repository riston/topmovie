
defmodule Subclub.MovieListParser do

    def start(content) do
        Floki.parse(content)
        |> Floki.find("#tale_list tr[class^=alt]")
        |> Enum.map(fn(x) -> parse_row(x) end)
    end

    defp id(row) do
        row
        |> Floki.find("span")
        |> Floki.attribute("id")
        |> hd
            |> String.split("_")
            |> Enum.take(-1)
            |> hd
            |> integer_default_parse
    end

    defp title(row) do
        row
        |> Floki.find("span > a.sc_link")
        |> hd
        |> Floki.text
            |> String.trim
            |> String.split(~r{[\n\r]+})
            |> hd
            |> String.trim
    end

    defp year(row) do
        row
        |> Floki.find("span > a.sc_link")
        |> hd
        |> Floki.text
            |> String.trim
            |> String.split("\n\n")
        |> Enum.take(-1)
        |> hd
        |> year_default_parse
    end

    defp view_count(row) do
        row
        |> Floki.find("td")
        |> Enum.at(8)
        |> Floki.text
            |> String.trim
            |> integer_default_parse
    end

    defp format(row) do
        row
        |> Floki.find("td span.formaat")
        |> Floki.text
            |> String.trim
    end

    defp fps(row) do
        row
        |> Floki.find("td span.fps")
        |> Floki.text
            |> String.trim
            |> float_default_parse
    end

    defp imdb_link(row) do
        row
        |> Floki.find("td")
        |> Enum.at(7)
        |> Floki.find("a")
        |> Floki.attribute("href")
        |> hd
    end

    defp score(row) do
        row
        |> Floki.find("td span[title]")
        |> Floki.text
            |> String.trim
            |> float_default_parse
    end

    defp author(row) do
        row
        |> Floki.find("td")
        |> Enum.at(12)
        |> Floki.text
            |> String.trim
    end

    defp category(row) do
        row
        |> Floki.find("td")
        |> Enum.at(6)
        |> Floki.text
            |> String.split(",")
            |> Enum.map(fn(x) -> String.trim(x) end)
    end

    defp created_at(row) do
        row
        |> Floki.find("td")
        |> Enum.at(0)
        |> Floki.text
            |> String.split("\n")
            |> Enum.at(0)
            |> default_date
    end

    defp modified_at(row) do
        row
        |> Floki.find("td")
        |> Enum.at(0)
        |> Floki.text
            |> String.split("\n")
            |> Enum.at(1)
            |> default_date
    end

    def float_default_parse(x) do
        case Float.parse(x) do
            {num, _} -> num
            :error -> 0
        end
    end

    def integer_default_parse(x) do
        case Integer.parse(x) do
            {num, _} -> num
            :error -> 0
        end
    end

    def year_default_parse(x) do
        case Regex.named_captures(~r/(?<num>\d{4})/, x)  do
            %{"num" => year} -> String.to_integer(year)
            nil -> 1900
        end
    end

    def date_parse(x) do
        case Regex.named_captures(~r/(?<day>\d{2})\.(?<month>\d{2})\.(?<year>\d{4})/, x)  do
            %{"day" => day, "month" => month, "year" => year} ->
                Date.new(String.to_integer(year), String.to_integer(month), String.to_integer(day))
            nil -> Date.new(1900, 1, 1)
        end
    end

    def default_date(x) do
        case date_parse(x) do
            {:ok, time} -> time
            {:error, _} -> Date.new(1900, 1, 1)
        end
    end

    defp parse_row(row) do
        %{
            id: id(row),
            title: title(row),
            year: year(row),
            view_count: view_count(row),
            score: score(row),
            fps: fps(row),
            format: format(row),
            imdb_link: imdb_link(row),
            author: author(row),
            category: category(row),
            updated_at: modified_at(row),
            inserted_at: created_at(row)
        }
    end
end
