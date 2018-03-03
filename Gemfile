source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '~> 5.1.5'

gem 'bcrypt' # Use ActiveModel has_secure_password
gem 'bootstrap'
gem 'font-awesome-rails' # https://github.com/bokmann/font-awesome-rails
gem 'haml-rails'
gem 'jbuilder' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails'
gem 'pg'
gem 'puma' # Use Puma as the app server
gem 'sass-rails' # Use SCSS for stylesheets
gem 'turbolinks' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'uglifier' # Use Uglifier as compressor for JavaScript assets

# gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production

group :development, :test do
  gem 'capybara' # Adds support for Capybara system testing and selenium driver
  gem 'foreman'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem "pry-byebug"
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov'
end
