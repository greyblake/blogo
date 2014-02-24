module Blogo
  class Engine < ::Rails::Engine
    isolate_namespace Blogo
    engine_name "blogo"

    config.generators do |g|
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.test_framework :rspec, :fixture => false
    end

    config.assets.precompile += %W(
      blogo/*.js
      blogo/*.css
      blogo/*.png
      blogo/*.gif
      blogo/*.html
      blogo/*.md
    )
  end
end
