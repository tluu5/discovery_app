# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "capybara/rails"
require "capybara/rspec"
require 'database_cleaner/active_record'
require 'factory_bot_rails'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

# Load support files
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

# Ensure migrations are up to date
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

# Register a custom Safari driver for Capybara
Capybara.register_driver :selenium_safari do |app|
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

# Configure Capybara to use Safari for JavaScript tests
Capybara.javascript_driver = :selenium_safari

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  # Save test results and stop on first failure (optional)
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.fail_fast = false
  config.formatter = :documentation

  config.include FactoryBot::Syntax::Methods

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature

  config.include Warden::Test::Helpers, type: :feature
  config.after(:each, type: :feature) do
    Warden.test_reset!
  end

  # Capybara DSL globally accessible
  config.include Capybara::DSL

  # Fixture settings
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

  # Infer test type based on file location
  config.infer_spec_type_from_file_location!

  # Clean database between tests
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }

  # Filter Rails backtrace
  config.filter_rails_from_backtrace!
end
