$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blogo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blogo"
  s.version     = Blogo::VERSION
  s.authors     = ["Sergey Potapov"]
  s.email       = ["blake131313@gmail.com"]
  s.homepage    = "https://github.com/greyblake/blogo"
  s.summary     = "Mountable blog engine for Ruby on Rails"
  s.description = "Mountable blog engine for Ruby on Rails. It allows you to quickly add a featured blog to an existing rails application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["rspec/**/*"]

  s.add_dependency "rails"      , "~> 4.0"
  s.add_dependency "jquery-rails"
  s.add_dependency 'coffee-rails'
  s.add_dependency "bcrypt-ruby", "~> 3.0"
  s.add_dependency "sass-rails" , "~> 4.0"
end
