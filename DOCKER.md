# Some notes taken while dockerizing the app

* https://hackernoon.com/dockerizing-an-existing-rails-postgresql-app-with-docker-compose-a30a7e1b3f40

### Starting/stopping

* `docker-compose up` or `docker-compose up --build`
* `docker-compose down`

### PostgreSQL setup

* Not working due to env issues: https://github.com/docker-library/postgres/issues/203

### Rails

#### Database 
* `docker-compose exec web rails db:create RAILS_ENV=development`
* `docker-compose exec web rails db:schema:load RAILS_ENV=development`
* `docker-compose exec web rails db:create RAILS_ENV=test`
* `docker-compose exec web rails db:schema:load RAILS_ENV=test`

#### Tests
* `docker-compose exec web rspec`