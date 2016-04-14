ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'features/feature_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
require 'support/database_cleaner'
# Add additional requires below this line. Rails is not loaded until this point!

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

end
