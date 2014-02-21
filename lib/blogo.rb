require 'blogo/version'
require 'blogo/errors'
require 'blogo/engine'
require 'blogo/config'

require 'blogo/renderer'


module Blogo
  mattr_accessor :config
  self.config = Blogo::Config.new

  # Table name prefix for tables.
  #
  # @return [String]
  def self.table_name_prefix
    config.table_name_prefix
  end

  # Configure the engine.
  def self.configure
    yield(config)
  end
end
