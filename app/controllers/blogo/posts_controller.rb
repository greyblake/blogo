class Blogo::PostsController < Blogo::ApplicationController
  layout 'blogo/application'

  def index
    @recent_posts = Blogo::Post.published
    @posts = Blogo::Post.published
    @tags = Blogo::Tag.all
  end

  def show
    @post = Blogo::Post.published.where(:url => params[:post_url]).first!
    @recent_posts = Blogo::Post.published
    @tags = Blogo::Tag.all
  end
end
