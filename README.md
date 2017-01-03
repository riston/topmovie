# Topmovie

Scrape the subclub.eu movie listing page and aggregate the results. Showing the top movies based
on the downloaded subtitles. [Demo](https://top-subclub.herokuapp.com)

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

%Themoviedb.Movie{
    id: 10719, 
    title: "Elf", 
    overview: "When young Buddy falls into Santa's gift sack on Christmas Eve, he's transported back to the North Pole and raised as a toy-making elf by Santa's helpers. But as he grows into adulthood, he can't shake the nagging feeling that he doesn't belong. Buddy vows to visit Manhattan and find his real dad, a workaholic publisher.", 
    adult: false, 
    backdrop_path: "/iPIR4LG5cylMteoPJ1VUpnXDtYP.jpg", 
    genre_ids: [10749, 35, 10751, 14], 
    original_title: "Elf", 
    popularity: 4.096822, 
    poster_path: "/9jChHqqcpe0zHNTqkNqWZkwkgil.jpg", 
    release_date: "2003-10-09", 
    video: false, 
    vote_average: 6.5, 
    vote_count: 579}

mix phoenix.gen.html MovieInfo movie_info id:integer title:string overview:string adult:boolean video:boolean backdrop_path:string genres:array:string popularity:float poster_path:string vote_average:float vote_count:integer
```

## Integration themoviedb.org data

```GET https://api.themoviedb.org/3/find/{external_id}?api_key=<<api_key>>&language=en-US&external_source=imdb_id```
