[![Maintainability](https://api.codeclimate.com/v1/badges/2e93f28fbf031c6e2f79/maintainability)](https://codeclimate.com/github/mejialvarez/rn-test/maintainability)

# README
This is an API REST that uses Ruby on Rails 6 and PostgreSQL as the database.

## Requirements

In order to install and run the project locally you need to have the following installed:

* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

Download the project by cloning it from Git:

```
$ git clone git@github.com:mejialvarez/rn-test.git
```

Run docker compose:

```
$ docker-compose build
$ docker-compose up
```

Create the database and run the migrations by executing:

```
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
```

You can seed the database running:

```
$ docker-compose run web rails db:seed
```

## API REST

https://rna-test.herokuapp.com/api/v1

Documentation:
https://app.swaggerhub.com/apis-docs/mejialvarez1/rn-test/1.0.0-oas3