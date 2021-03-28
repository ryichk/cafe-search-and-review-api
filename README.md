# Cafe Shares

* Ruby version
2.6.0

* Set up Docker

```bash
 docker-compose up --build
 docker-compose run --rm web bundle install
```

* System dependencies

* Configuration

* Database creation

```bash
 docker-compose run --rm web bundle exec rails db:create
```

* Database initialization

```bash
 docker-compose run --rm web bundle exec rails db:migrate
```

* How to run the test suite

```bash
 docker-compose run --rm web bundle exec rspec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
