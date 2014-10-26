# Copies initializer file with default settings.
class Blogo::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  # :nodoc:
  def copy_initializer_file
    copy_file "initializer.rb", "config/initializers/blogo.rb"
  end
end
