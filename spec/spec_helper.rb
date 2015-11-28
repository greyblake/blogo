ENV['RAILS_ENV'] ||= 'test'

require 'coveralls'
Coveralls.wear!

require File.expand_path("../dummy/config/environment.rb", __FILE__)

require 'rspec'
require 'rspec/rails'
require 'factory_girl_rails'
require 'capybara/rails'
require 'capybara/rspec'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load factories
Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |f| require f }

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  config.include ControllerHelpers, type: :controller
  config.include FeatureHelpers   , type: :feature
end
