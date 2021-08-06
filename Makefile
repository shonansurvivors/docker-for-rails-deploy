bundle-install:
	docker-compose run --rm app bundle install --without production

bundle-update:
	docker-compose run --rm app bundle update

db-migrate:
	docker-compose run --rm app bundle exec rails db:migrate RAILS_ENV=development

precompile:
	docker-compose run --rm app bundle exec rails assets:precompile RAILS_ENV=development

test:
	docker-compose run --rm app bundle exec rails test

up:
	docker-compose up -d

stop:
	docker-compose stop

yarn:
	docker-compose run --rm app yarn install

remove-credentials:
	docker-compose run --rm app rm config/credentials.yml.enc

create-credentials:
	docker-compose run --rm -e EDITOR=vi app bundle exec rails credentials:edit
