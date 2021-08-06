# Docker for rails-deploy

## rails-deploy

https://github.com/shonansurvivors/rails-deploy

## Prepare

```
.
├── this docker repogitory
└── your rails repogitory
    ├── app
    ├── bin
    └── etc...
```

```
# this docker repository

cp .env.example .env
```

```
# your_rails_repo/.gitignore

/vendor
```

## Build

```
make bundle-update
make db-migrate
make yarn
make precompile
```

or

```
make bundle-install
make db-migrate
make yarn
make precompile
```

## client -> puma

```ruby
# your_rails_repo/config/puma.rb example

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "production" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
plugin :tmp_restart
# app_root = File.expand_path("../..", __FILE__)
# bind "unix:#{app_root}/tmp/sockets/puma.sock"
```

```yaml
# this_docker_repo/docker-compose.yml
  app:
    build:
      context: .
      dockerfile: ruby/Dockerfile
    command: bundle exec rails s -b '0.0.0.0'
    # command: bundle exec puma -e development
```

```
make up # You don't care about nginx running
```

```
curl -I localhost:3000
```

## client -> nginx -> unix domain socket -> puma

```ruby
# your_rails_repo/config/puma.rb example

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "production" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
plugin :tmp_restart
app_root = File.expand_path("../..", __FILE__)
bind "unix:#{app_root}/tmp/sockets/puma.sock"
```

```yaml
# this_docker_repo/docker-compose.yml
  app:
    build:
      context: .
      dockerfile: ruby/Dockerfile
    # command: bundle exec rails s -b '0.0.0.0'
    command: bundle exec puma -e development
```

```
make up
```

```
curl -I localhost
```
