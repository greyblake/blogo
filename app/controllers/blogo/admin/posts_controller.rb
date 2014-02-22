module Blogo::Admin
  class PostsController < BaseController

    def index
      @posts = Blogo::Post.all
    end

    def new
      @post = Blogo::Post.new(published: true)
    end

    def create
      service = Blogo::CreatePostService.new(blogo_current_user, post_params)

      if service.create!
        @post = service.post
        flash.now[:notice] = "The post is created"
        render 'show'
      else
        @post = service.post
        render 'new'
      end
    end

    def show
      @post = Blogo::Post.find(params[:id])
      @recent_posts = Blogo::Post.all
      @tags = Blogo::Tag.all
    end

    def edit
      @post = Blogo::Post.find(params[:id])
    end

    def update
      @post = Blogo::Post.find(params[:id])
      service = Blogo::UpdatePostService.new(@post, post_params)

      if service.update!
        flash.now[:notice] = "The post is updated"
        render 'show'
      else
        render 'edit'
      end
    end

    def destroy
      post = Blogo::Post.find(params[:id])
      Blogo::DestroyPostService.new(post).destroy!

      flash[:notice] = "The post is removed"
      redirect_to admin_posts_path
    end


    private

    def post_params
      params.require(:post).permit(:title, :url, :published_at, :raw_content, :published, :tags_string)
    end
  end
end
