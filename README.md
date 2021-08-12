# Membership Register

Keeps track of membership to a society.

## Getting started

### Prerequisites

* Ruby (See `.ruby-version` for the version you have to install)
* Postgres

### Set-up

Clone this repository and run the following from the working directory:

    bin/setup

This will install dependencies and create a development and test database.

### Start

To start a local server, run:

    bin/rails server

By default, this will start a local webserver on [http://localhost:3000](http://localhost:3000)


## Testing

This codebase started out without tests. Some are being introduced over time.

To run tests:

    bundle exec rspec

## Voting

Voting can be enabled by setting a `VOTE_URL_TEMPLATE` environment variable.

    VOTE_URL_TEMPLATE=https://voting-site.com/token=%token%

When set, a message will appear on the home page, and members will be able to get a unique link emailed to them through a form, which substitutes `%token%` in the URL template with each member's unique `voting_token`.

## Maintenance

### Upgrading Rails

Follow the [Upgrading Rails Guide](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html) which, as of May 10, 2020 suggests updating each Rails version incrementally and running `bin/rails app:update` to compare new defaults.
