module Blogo
  class Config
    attr_accessor :site_title
    attr_accessor :site_subtitle
    attr_accessor :table_name_prefix
    attr_accessor :posts_per_page
    attr_accessor :paginator_size
    attr_accessor :recent_posts
    attr_accessor :disqus_shortname
    attr_reader :renderer

    # Set default values.
    def initialize
      @site_title        = 'Blogo'
      @site_subtitle     = 'Mountable blog engine for Ruby on Rails'
      @table_name_prefix = 'blogo_'
      @posts_per_page    = 10
      @paginator_size    = 5
      @recent_posts      = 5
      @disqus_shortname  = nil

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
