# Corner

> Helping drive every day usage of crypto at corner stores and beyond

![tweet](https://github.com/helios-coop/corner/blob/master/app/assets/images/jamseson_lopp_tweet.jpg?raw=true)

[link](https://twitter.com/lopp/status/975398250709766144)

## Installation

OS X & Linux:

### Postgres

```sh
brew install postgresql
```

## Ruby on Rails

If you do not have Rails, use this [guide](http://installrails.com).

## Development setup

For code quality purposes, we use [Rubocop](https://github.com/bbatsov/rubocop). Download for your specified IDE. Circle CI will fail if any Rubocop style violations are found.

---

We use two files for Environment Variables.
The `.env` file is included in the repo and has public env vars.

Create files named `.env.local` and `.env.test.local` to hold secret env vars.
In the `.env` file look at the section titled: **Secret Environment Variables**.

Copy the key value pairs to `.env.local` and `.env.test.local`. Then find
someone on the team to share the values with you.

---

To ensures all dependencies are available to your application.

```sh
bundle install
```

---

Make sure Postgres is running. Run to set up your database.

```sh
rake db:create:all
```

and

```sh
bin/rails db:migrate RAILS_ENV=development
```

---

To run all servers (web and workers) locally:

```sh
foreman start -f Procfile.dev
```

**note you won't be able to use `binding.pry`**

OR

If you want to use `binding.pry` (because its the coolest) start the servers seperately in their own tabs:

```sh
rails server
```

and

```sh
< TODO: sidekiq startup goes here >
```

and then navigate to `localhost:3000`

## Data Model

Keep this updated:

https://drive.google.com/file/d/13rWZlBrkVmeWPsVDByswylRkaf30jm_F/view?usp=sharing

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
