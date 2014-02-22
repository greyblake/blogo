module Blogo
  class PostsController < ApplicationController
    layout 'blogo/application'

    def index
      set_vars
      set_paginator
    end

    def show
      @post = Post.published.where(:url => params[:post_url]).first!
      set_vars
    end


    private

    def set_paginator
      @paginator = Paginator.new(
        Post.published,
        :page     => (params[:page] || 1),
        :per_page => Blogo.config.posts_per_page,
        :size     => Blogo.config.paginator_size)
    end

    def set_vars
      @recent_posts = Post.published
      @tags = Tag.all
    end
  end
end
