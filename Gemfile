# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.4.4"

# needs to be included before any other gems that use environment variables
gem "dotenv-rails", groups: [:development, :test]
gem "rails", "~> 5.2.0"

gem "aws-sdk-s3", require: false
gem "bcrypt" # Use ActiveModel has_secure_password
gem "bootsnap", require: false
gem "bootstrap" # Using v4.0 https://getbootstrap.com/docs/4.0/getting-started/introduction/
gem "browser"
gem "dalli"
gem "font-awesome-rails" # https://github.com/bokmann/font-awesome-rails
gem "geocoder"
gem "gon"
gem "google_places"
gem "haml-rails"
gem "honeybadger"
gem "jbuilder" # Build JSON APIs with ease
gem "jquery-rails"
gem "paranoia"
gem "pg"
gem "pg_search"
gem "puma" # Use Puma as the app server
gem "sass-rails" # Use SCSS for stylesheets
gem "semantic-ui-sass"
gem "sidekiq"
gem "slack-notifier"
gem "turbolinks" # Makes navigating your web application faster
gem "uglifier" # Use Uglifier as compressor for JavaScript assets

# gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production

group :development, :test do
  gem "brakeman", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "foreman", require: false
  gem "guard", require: false
  gem "guard-rspec", require: false
  gem "guard-rubocop", require: false
  gem "haml_lint", require: false
  gem "pry-byebug"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "listen"
  gem "spring" # Speeds up development by keeping your application running
  gem "spring-watcher-listen"
  gem "web-console" # Access an IRB console on exception pages
end

group :test do
  gem "capybara"
  gem "capybara-screenshot", require: false
  gem "chromedriver-helper"
  gem "rspec_junit_formatter", require: false
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "vcr", require: false
  gem "webmock", require: false
end
