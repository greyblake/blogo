require 'spec_helper'

describe 'Edit Post' do
  before do
    FactoryGirl.create(:post, title: 'The new reality of Ukraine')
  end

  it 'update post' do
    login!

    click_link 'The new reality of Ukraine'
    fill_in 'post[title]', with: 'Hope we will avoid the war'
    click_button 'Save'

    expect(page).to have_content("The post is updated")

    post = Blogo::Post.first
    expect(post.title).to eq 'Hope we will avoid the war'
  end
end
