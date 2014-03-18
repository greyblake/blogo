require 'spec_helper'

describe Blogo::Admin::PostsController do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user) }

  it 'redirects if user is not logged in' do
    logout!

    get :index
    expect(response).to redirect_to blogo_admin_login_url
  end

  describe '#index' do
    it 'sets @posts' do
      posts = FactoryGirl.create_list(:post, 3)
      get :index

      expect(response).to be_ok
      expect(assigns(:posts)).to match_array(posts)
    end
  end

  describe '#new' do
    it 'sets new @post' do
      get :new
      expect(response).to be_ok
      expect(assigns(:post)).to be_a Blogo::Post
      expect(assigns(:post)).to be_new_record
    end
  end

  describe '#create' do
    context 'valid parameters' do
      it 'creates new post' do
        post :create,
          post: {
            title: 'How to use Vim for Ruby',
            permalink: 'howto-vim-ruby',
            published_at: '2013-01-01 07:45:00',
            raw_content: 'Do you like Vim?<!--more--> I do!',
            published: false,
            tags_string: 'ruby, vim'
          }

        expect(response).to redirect_to blogo_admin_posts_path
        expect(flash[:notice]).to eq 'The post is created'

        new_post = Blogo::Post.last
        expect(new_post.title).to eq 'How to use Vim for Ruby'
        expect(new_post.permalink).to eq 'howto-vim-ruby'
        expect(new_post.published_at).to eq DateTime.new(2013, 01, 01, 07, 45)
        expect(new_post.raw_content).to eq 'Do you like Vim?<!--more--> I do!'
        expect(new_post.html_content).to eq 'Do you like Vim? I do!'
        expect(new_post.html_overview).to eq 'Do you like Vim?'
        expect(new_post).not_to be_published
        expect(new_post.tag_names).to eq ['ruby', 'vim']
        expect(new_post.tags.map(&:name)).to match_array(['ruby', 'vim'])
      end
    end

    context 'invalid paramters' do
      it 'does not create new post' do
        expect {
          post :create, post: {title: 'Get on with Redis!'}
        }.not_to change { Blogo::Post.count }

        expect(response).to render_template('new')

        new_post = assigns(:post)
        expect(new_post.title).to eq 'Get on with Redis!'
        expect(new_post.errors).not_to be_empty
      end
    end
  end

  describe '#edit' do
    it 'sets @post' do
      blog_post  = FactoryGirl.create(:post)
      get :edit, id: blog_post.id

      expect(response).to be_ok
      expect(assigns(:post)).to eq blog_post
    end
  end

  describe '#update' do
    let(:blog_post) { FactoryGirl.create(:post, title: 'Ne lernu la anglan') }

    context 'params are valid' do
      it 'updates post' do
        post :update, id: blog_post.id, post: {title: 'Lernu Esperanton!'}

        expect(response).to redirect_to blogo_admin_posts_path
        expect(flash[:notice]).to eq 'The post is updated'

        blog_post.reload
        expect(blog_post.title).to eq 'Lernu Esperanton!'
      end
    end

    context 'params are invalid' do
      it 'does not update post' do
        post :update, id: blog_post.id, post: {title: ''}

        expect(response).to be_ok
        expect(assigns(:post).errors).not_to be_empty
      end
    end
  end

  describe '#destroy' do
    it 'deletes post' do
      blog_post = FactoryGirl.create(:post)
      delete :destroy, id: blog_post.id

      expect(response).to redirect_to blogo_admin_posts_path
      expect(flash[:notice]).to eq 'The post is removed'

      expect(Blogo::Post.where(id: blog_post.id)).to be_empty
    end
  end

  describe '#preview' do
    it 'builds post for preview' do
      post :preview, post: {title: 'For Preview', raw_content: 'Korpo'}

      expect(response).to be_ok
      expect(response).to render_template 'blogo/posts/show'

      expect(assigns(:meta)).to eq title: 'For Preview'
      expect(assigns(:tags)).not_to be_nil

      preview_post = assigns(:post)
      expect(preview_post.title).to eq 'For Preview'
      expect(preview_post.raw_content).to eq 'Korpo'
    end
  end
end
