RSpec.configure do |config|
  # Clean the database before the entire test suite runs
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # Use the transaction strategy by default
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # Use the truncation strategy for tests requiring JavaScript
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  # Start DatabaseCleaner before each test
  config.before(:each) do
    DatabaseCleaner.start
  end

  # Clean the database after each test
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
