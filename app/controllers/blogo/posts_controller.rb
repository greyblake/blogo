module Blogo
  class PostsController < ApplicationController
    layout 'blogo/application'

    # Number of posts shown in feed.
    FEED_POSTS_LIMIT = 20

    def index
      @tag = params[:tag]
      set_vars
      set_paginator
    end

    def show
      @post = Post.published.where(:url => params[:post_url]).first!
      set_vars
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
  end
end
