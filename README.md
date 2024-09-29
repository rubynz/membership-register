# Membership Register

Keeps track of membership to a society.

## Getting started

(Docker version follows).

### Prerequisites

* Ruby (See `.ruby-version` for the version you have to install)
* Nodejs (for building assets, not required for production)
* Postgres

### Set-up

Install dependencies, copy `config/database.yml.sample` to `config/database.yml`:

    cp config/database.yml.sample config/database.yml

Edit `config/database.yml` according to your setup.

Then run:

    bin/setup
    yarn install

This will install dependencies, create a development and test database, and install nodejs dependencies.

### Start

To start a local server, run:

    bin/rails server

By default, this will start a local webserver on [http://localhost:3000](http://localhost:3000)

And

    yarn build --watch

To run tests:

    bundle exec rspec

## Getting started (using docker)

Install [docker](https://docs.docker.com/engine/install/) and
[docker compose](https://docs.docker.com/compose/install/).

Copy files:

    cp docker-compose.yml.sample docker-compose.yml
    cp config/database.yml.docker config/database.yml

Edit them according to your setup and preferences.

NOTE: leave `RAILS_ENV: test` or change it to `RAILS_ENV: development` in
`docker-compose.yml`. Either value does the same.

Then run:

    docker compose pull
    docker compose build
    docker compose run --rm app ./bin/setup

To start:

    docker compose up app assets

To run the tests:

    docker compose run --rm app bundle exec rspec

## Voting

Voting can be enabled by setting a `VOTE_URL_TEMPLATE` environment variable.

    VOTE_URL_TEMPLATE=https://voting-site.com/token=%token%

When set, a message will appear on the home page, and members will be able to get a unique link emailed to them through a form, which substitutes `%token%` in the URL template with each member's unique `voting_token`.

## Deployment

To deploy this app you need Nodejs to compile the assets, but only Ruby to run the production server.

Heroku should identify you need those two dependencies, if it does not, please refer to the [Buildpacks](https://devcenter.heroku.com/articles/buildpacks) documentation.
