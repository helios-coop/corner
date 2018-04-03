# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '~> 5.1.5'

# https://github.com/ActsAsParanoid/acts_as_paranoid/issues/36
gem 'acts_as_paranoid', github: 'ActsAsParanoid/acts_as_paranoid'
gem 'bcrypt' # Use ActiveModel has_secure_password
gem 'bootstrap'
gem 'dalli'
gem 'font-awesome-rails' # https://github.com/bokmann/font-awesome-rails
gem 'geocoder'
gem 'gon'
gem 'google_places'
gem 'haml-rails'
gem 'honeybadger'
gem 'jbuilder' # Build JSON APIs with ease
gem 'jquery-rails'
gem 'pg'
gem 'pg_search'
gem 'puma' # Use Puma as the app server
gem 'sass-rails' # Use SCSS for stylesheets
gem 'sidekiq'
gem 'turbolinks' # Makes navigating your web application faster
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # for Windows
gem 'uglifier' # Use Uglifier as compressor for JavaScript assets

# gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production

group :development, :test do
  gem 'capybara' # Adds support for Capybara system testing and selenium driver
  gem 'dotenv-rails' # Move to the top if you need Env Vars before rails loads.
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'foreman'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring' # Speeds up development by keeping your application running
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an IRB console on exception pages
end

group :test do
  gem 'rspec_junit_formatter', require: false
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
