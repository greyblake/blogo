module Blogo
  class Engine < ::Rails::Engine

    engine_name "blogo"

    config.generators do |g|
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end

  end
end
