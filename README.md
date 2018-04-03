# Corner
> Helps drive every day usage of crypto at corner stores and beyond

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

For code quality purposes, we use (Rubocop). Download for your specified IDE.

To ensures all dependencies are available to your application.
```sh
bundle install
```

Make sure Postgres is running. Run to set up your database.
```sh
rake db:create:all
```

and

```sh
bin/rails db:migrate RAILS_ENV=development
```

To run the app locally:
```sh
rails s
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
