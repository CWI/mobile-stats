source 'https://rubygems.org'

# Ruby
ruby '2.0.0'

# Gems
gem 'rails', '3.2.13'
gem 'coveralls', require: false

# Assets
group :assets do
  gem 'uglifier', '>= 1.0.3'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.3.2.0'
  gem 'jquery-rails'
end

# Use PostgreSQL in Production
group :production do
  gem 'pg'
end

# Development, Test
group :development, :test do
  gem 'sqlite3'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'pry'
  gem 'pry-nav'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'jasmine-headless-webkit'
  gem 'headless'
end

# Test
group :test do
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'capybara-webkit'
  gem 'webmock'
  gem 'vcr'
  gem 'database_cleaner'
end
