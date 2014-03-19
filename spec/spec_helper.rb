ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'capybara/rails'


Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load factories
Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false

  def admin_login
    user = FactoryGirl.create(:user)
    session[:blogo_user_id] = user.id
  end

  def fixture_image(name)
    File.join(Blogo::Engine.root, 'spec/fixtures/images', name)
  end

  def login_as(user)
    session[:blogo_user_id] = user.id
  end

  def login!
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  def logout!
    session[:blogo_user_id] = nil
  end
end
