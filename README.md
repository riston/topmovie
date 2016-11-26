# Topmovie

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Some of the query examples

```
import Ecto.Query

query = from m in "movies", order_by: [desc: :view_count], select: [:title, :view_count]
Topmovie.Repo.all(query)
```

```
movie = Topmovie.Repo.get(Topmovie.Movie, 16720)
movie = Topmovie.Repo.preload(movie, :views)

# Get the movie with views included
import Ecto.Query
query = from(v in Topmovie.Movie.View, select: {avg(v.view_count), v.inserted_at, v.movie_id}, group_by: [:inserted_at,:movie_id], ,order_by: v.inserted_at)
movie = Topmovie.Movie\
    |> Topmovie.Repo.get(16720)\
    |> Topmovie.Repo.preload(views: query)
```

```
import Ecto.Query
movieQuery = from(m in Topmovie.Movie,
    order_by: [desc: v.updated_at]
    )
viewQuery = from(v in Topmovie.Movie.View,
    select: {v.movie_id, max(v.view_count), fragment("DATE(?)", v.inserted_at)},
    group_by: [v.movie_id, fragment("DATE(?)", v.inserted_at)])

movie = Topmovie.Movie\
    |> Topmovie.Repo.get(16720)\
    |> Topmovie.Repo.preload(views: query)
```


```
import Ecto.Query
movieQuery = from(m in Topmovie.Movie,
    order_by: [desc: m.updated_at],
    limit: 25)

viewQuery = from(v in Topmovie.Movie.View,
    select: {v.movie_id, max(v.view_count), fragment("DATE(?)", v.inserted_at)},
    group_by: [v.movie_id, fragment("DATE(?)", v.inserted_at)])

movie = movieQuery\
    |> Topmovie.Repo.all\
    |> Topmovie.Repo.preload(views: viewQuery)
```

## Creating ecto models

```
mix phoenix.gen.html Movie movies title:string year:integer fps:float score:float author:string view_count:integer category:array:string
```
## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
