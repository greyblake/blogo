module Blogo
  class Config
    attr_accessor :site_title
    attr_accessor :site_subtitle

    attr_accessor :table_name_prefix

    attr_accessor :posts_per_page
    attr_accessor :archive_posts_per_page
    attr_accessor :paginator_size
    attr_accessor :recent_posts

    attr_accessor :keywords

    attr_accessor :disqus_shortname
    attr_accessor :twitter_username
    attr_accessor :github_username
    attr_accessor :show_rss_icon
    attr_accessor :google_analytics_id

    attr_accessor :use_ckeditor

    attr_reader :markup_lang

    # Set default values.
    def initialize
      @site_title          = 'Blogo'
      @site_subtitle       = 'Mountable blog engine for Ruby on Rails'
      @table_name_prefix   = 'blogo_'
      @posts_per_page      = 10
      @archive_posts_per_page = 10
      @paginator_size      = 5
      @recent_posts        = 5
      @disqus_shortname    = nil
      @google_analytics_id = nil
      @use_ckeditor        = true
      @keywords            = %w(blog)
      @markup_lang         = :html
      @show_rss_icon       = true
    end

    def markup_lang=(lang)
      # Try to find a renderer for the format otherwise raise
      Blogo::Renderer.get(lang.to_sym)
      @format = lang.to_sym
    end
  end
end
