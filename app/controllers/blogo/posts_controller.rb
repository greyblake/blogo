module Blogo
  class PostsController < ApplicationController
    layout 'blogo/blog'

    # Number of posts shown in feed.
    FEED_POSTS_LIMIT = 20

    def index
      @tag = params[:tag]
      set_vars
      set_paginator

      @meta = {}
      @meta[:title]         = "#{Blogo.config.site_title} - #{Blogo.config.site_subtitle}"
      @meta[:site_name]     = Blogo.config.site_title
      @meta[:keywords]      = Blogo.config.keywords
      @meta[:type]          = 'website'
    end

    def show
      @post = Post.published.where(:permalink => params[:permalink]).first!
      set_vars

      @meta = {}
      @meta[:title]         = "#{@post.title} - #{Blogo.config.site_title}"
      @meta[:description]   = @post.meta_description
      @meta[:keywords]      = [@post.tags_string, Blogo.config.keywords].flatten.join(", ")
      @meta[:url]           = request.url
      @meta[:image]         = meta_image
      @meta[:type]          = 'article'
      @meta[:site_name]     = Blogo.config.site_title
    end

    def feed
      @posts   = published_posts.limit(FEED_POSTS_LIMIT)
      @updated = @posts.first.try(:updated_at)

      render 'feed', layout: false
    end


    private

    def set_paginator
      posts = published_posts
      posts = posts.joins(:tags).where("#{Tag.table_name}.name = ?", @tag) if @tag

      @paginator = Paginator.new(
        posts,
        :page     => (params[:page] || 1),
        :per_page => conf.posts_per_page,
        :size     => conf.paginator_size)
    end

    def set_vars
      @recent_posts = published_posts.limit(conf.recent_posts) if conf.recent_posts
      @tags = Tag.all
    end


    def published_posts
      Post.published
    end

    # Engine configuration. Method +config+ is already used by Rails.
    #
    # @return [Blogo::Config]
    def conf
      Blogo.config
    end


    def meta_image
      return nil unless @post.meta_image.present?
      if @post.meta_image =~ /\Ahttp/
        @post.meta_image
      else
        "#{request.protocol}#{request.host}#{@post.meta_image}"
      end
    end
  end
end
