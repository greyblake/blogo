require 'spec_helper'

describe 'New Post' do
  before do
    FactoryGirl.create(:user, email: 'admin@mail.com', password: 'sekreto')

    visit blogo_admin_login_path

    fill_in 'email'   , with: 'admin@mail.com'
    fill_in 'password', with: 'sekreto'
    click_button 'Login'

    expect(current_path).to eq blogo_admin_path
  end

  it 'creates a new post' do
    click_link "New Post"

    fill_in 'post[title]'       , with: 'The New Post'
    fill_in 'post[raw_content]' , with: 'Hi!<!--more-->How are you?'
    fill_in 'post[tags_string]' , with: 'smalltalk, ruby'
    fill_in 'post[permalink]'   , with: 'new-post'
    fill_in 'post[published_at]', with: '2012-05-01'

    click_button 'Save'

    expect(page).to have_content 'The post is created'
    expect(current_path).to eq blogo_admin_posts_path

    new_post = Blogo::Post.last
    expect(new_post.title).to eq       'The New Post'
    expect(new_post.raw_content).to eq 'Hi!<!--more-->How are you?'
    expect(new_post.tags_string).to eq 'smalltalk, ruby'
    expect(new_post.permalink).to eq 'new-post'
    expect(new_post.published_at.to_date).to eq Date.new(2012, 5, 1)
  end
end
