module Blogo::Admin
  # Responsible for posts management: creation, editing, deletion, preview.
  class PostsController < BaseController

    # GET /admin/posts
    #
    def index
      @posts = Blogo::Post.all
    end

    # GET /admin/posts/new
    #
    def new
      @post = Blogo::Post.new(published: true)
    end

    # POST /admin/posts
    #
    def create
      service = Blogo::CreatePostService.new(blogo_current_user, post_params)

      if service.create!
        @post = service.post
        flash[:notice] = I18n.translate('admin.post_created')
        redirect_to blogo_admin_posts_path
      else
        @post = service.post
        render 'new'
      end
    end

    # GET /admin/posts/:id/edit
    #
    def edit
      @post = Blogo::Post.where(permalink: params[:id]).first!
    end

    # PATCH /admin/posts/:id
    #
    def update
      @post = Blogo::Post.where(permalink: params[:id]).first!
      service = Blogo::UpdatePostService.new(@post, post_params)

      if service.update!
        flash[:notice] = I18n.translate('admin.post_updated')
        redirect_to blogo_admin_posts_path
      else
        render 'edit'
      end
    end

    # DELETE /admin/posts/:id
    #
    def destroy
      post = Blogo::Post.find(params[:id])
      Blogo::DestroyPostService.new(post).destroy!

      flash[:notice] = I18n.translate('admin.post_removed')
      redirect_to blogo_admin_posts_path
    end

    # POST /admin/posts/preview
    #
    def preview
      @post         = Blogo::PreviewPostService.new(blogo_current_user, post_params).preview
      @meta         = {title: @post.title }
      @recent_posts = Blogo::Post.published.limit(Blogo.config.recent_posts) if Blogo.config.recent_posts
      @tags         = Blogo::Tag.all

      render 'blogo/posts/show', layout: 'blogo/blog'
    end


    private

    # Get post parameters from params.
    #
    # @return [Hash]
    def post_params
      params.require(:post).permit(:title, :permalink, :published_at, :raw_content, :published, :tags_string)
    end
  end
end
