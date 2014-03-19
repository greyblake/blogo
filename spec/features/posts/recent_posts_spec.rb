require 'spec_helper'

describe 'Recent Posts' do
  before do
    FactoryGirl.create(:post, title: 'Ruby and Vim')
    FactoryGirl.create(:post, title: 'Ruby with RSpec')
    FactoryGirl.create(:post, title: 'Ruby on Rails', permalink: 'ruby-on-rails')
  end

  it 'shows links to recent posts' do
    Blogo.config.stub(recent_posts: 2)
    visit blogo_root_path

    within('.blogo-recent-posts') do
      expect(page).to have_content('Ruby on Rails')
      expect(page).to have_content('Ruby with RSpec')
      expect(page).not_to have_content('Ruby and Vim')

      click_link 'Ruby on Rails'
    end

    # TODO: use path helper
    expect(current_path).to eq '/blog/ruby-on-rails'
  end


  it 'does not shows recent posts if config.recent_posts = nil' do
    Blogo.config.stub(recent_posts: nil)
    visit blogo_root_path

    expect(page).not_to have_selector('blogo-recent-posts')
  end
end
