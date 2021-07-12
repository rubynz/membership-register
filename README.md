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

## Maintenance

### Upgrading Rails

Follow the [Upgrading Rails Guide](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html) which, as of May 10, 2020 suggests updating each Rails version incrementally and running `bin/rails app:update` to compare new defaults.
