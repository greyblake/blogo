$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blogo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blogo"
  s.version     = Blogo::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Blogo."
  s.description = "TODO: Description of Blogo."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["rspec/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "bcrypt-ruby"
end
