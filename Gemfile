source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "aws-sdk-s3", require: false
gem "devise"
gem "rails-controller-testing"
gem 'kaminari'
gem 'dev_toolbar'
gem 'rubocop', require: false
gem 'rubocop-rails', require: false
gem 'bootstrap', '~> 5.3'
gem 'sassc-rails'
gem 'ransack'
gem 'rails_admin'

# Use Rails 7.1.3 or higher
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails
gem "sprockets-rails"

# Use PostgreSQL as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server
gem "puma"

# JavaScript support with import maps
gem "importmap-rails"

# Hotwire for Turbo and Stimulus
gem "turbo-rails"
gem "stimulus-rails"

# Build JSON APIs
gem "jbuilder"

# Redis for caching and Action Cable
gem "redis", "~> 4.0"

# Add Active Storage image processing
gem "image_processing", "~> 1.2"

# Windows compatibility for timezone data
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0.0"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry-rails"
  gem "rails_db"
  gem "annotate"
  gem "rails-erd"
  gem "draft_generators"
  gem "grade_runner"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "database_cleaner-active_record"
  gem "draft_matchers"
  gem "shoulda-matchers", "~> 5.0"
  gem "rspec-html-matchers"
  gem "webmock"
end

# App-specific gems
gem "active_link_to"
gem "appdev_support"
gem "awesome_print"
gem "dotenv"
gem "faker"
gem "htmlbeautifier"
gem "http"
gem "sqlite3", "~> 1.4"
gem "table_print"
gem "simple_form"
gem "carrierwave"
