# Movie Bookings

A Grape test application using Rake and Sequel

## Dependencies

* ruby 2.4.3
* postgresql

## How to setup
Create database.yml file in db folder or rename the sample

```bash
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

## Running specs

```bash
$ bundle exec rspec
```

## Running the app

```bash
$ rackup
```

The app is accessible here: http://localhost:9292/api

## Usage examples

Getting all the movies

```bash
curl -i http://localhost:9292/api/movies?week_day=1
```

```JSON
[{"id": 1, "title": "Star Wars", "description": "Some long description", "cover_url": "https://sample.url/sample.jpg", "week_days": ["Sunday", "Monday"]},
 {"id": 2, "title": "Star Wars 2", "description": "Some long description", "cover_url": "https://sample.url/sample2.jpg", "week_days": ["Monday", "Wednesday"]}]
```

Creating a movie

```bash
curl -d '{"title": "Lord of the Rings", "description": "Some long description", "cover_url": "https://sample.url/sample.jpg", "week_days": [0, 1]}' -X POST -H Content-Type:application/json http://localhost:9292/api/movies
```

Getting all the bookings

```bash
curl -i http://localhost:9292/api/bookings?from_date=2011-11-06&to_date=2011-11-07
```

```JSON
[{"id": 1, "first_name": "Boris", "last_name": "Yeltsin", "movie_title": "Perestroyka", "booked_at": "Sunday, 06 Nov 1:45 pm"},
 {"id": 2, "first_name": "Yuri", "last_name": "Gagarin", "movie_title": "Poyehali", "booked_at": "Sunday, 06 Nov 3:33 pm"}]
```

Creating a movie

```bash
curl -d '{"first_name": "Bruce", "last_name": "Wayne", "movie_id": 1, "booked_at": "2011-11-06 15:15"}' -X POST -H Content-Type:application/json http://localhost:9292/api/bookings
```
