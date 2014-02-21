module Blogo
  class Config

    attr_accessor :site_title

    attr_accessor :site_subtitle

    attr_reader :renderer

    attr_accessor :table_name_prefix


    # Set default values.
    def initialize
      @site_title        = 'Blogo'
      @site_subtitle     = 'Mountable blog engine for Ruby on Rails'
      @table_name_prefix = 'blogo_'

      self.renderer = :html
    end

    def renderer=(value)
      if value.respond_to?(:render)
        @renderer = value
      else
        @renderer = Blogo::Renderer.get(value.to_sym)
      end
    end
  end
end
