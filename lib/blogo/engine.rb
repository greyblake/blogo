module Blogo
  class Engine < ::Rails::Engine
    isolate_namespace Blogo
    engine_name "blogo"

    config.generators do |g|
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.test_framework :rspec, :fixture => false
    end
  end
end
