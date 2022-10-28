# Membership Register

Keeps track of membership to a society.

## Getting started

### Prerequisites

* Ruby (See `.ruby-version` for the version you have to install)
* Nodejs (for building assets, not required for production)
* Postgres

### Set-up

Clone this repository and run the following from the working directory:

    bin/setup
    yarn install

This will install dependencies, create a development and test database, and install nodejs dependencies.

### Start

To start a local server, run:

    bin/rails server

By default, this will start a local webserver on [http://localhost:3000](http://localhost:3000)

And

    yarn build --watch

## Testing

This codebase started out without tests. Some are being introduced over time.

To run tests:

    bundle exec rspec

## Voting

Voting can be enabled by setting a `VOTE_URL_TEMPLATE` environment variable.

    VOTE_URL_TEMPLATE=https://voting-site.com/token=%token%

When set, a message will appear on the home page, and members will be able to get a unique link emailed to them through a form, which substitutes `%token%` in the URL template with each member's unique `voting_token`.

## Deployment

To deploy this app you need Nodejs to compile the assets, but only Ruby to run the production server.

Heroku should identify you need those two dependencies, if it does not, please refer to the [Buildpacks](https://devcenter.heroku.com/articles/buildpacks) documentation.
