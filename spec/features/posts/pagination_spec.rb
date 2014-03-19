require 'spec_helper'

describe 'Pagination' do
  before do
    Blogo.config.stub(posts_per_page: 2)

    FactoryGirl.create(:post, title: 'Ruby and Vim'          , tags: %w(ruby vim))
    FactoryGirl.create(:post, title: 'Ruby with RSpec'       , tags: %w(ruby rspec))
    FactoryGirl.create(:post, title: 'Ruby on Rails         ', tags: %w(ruby rails))
    FactoryGirl.create(:post, title: 'How to grow up kittens', tags: %w(cats))
  end

  it 'shows pages' do
    # 1st page
    visit blogo_root_path
    within('#main') do
      expect(page).not_to have_content('Ruby and Vim')
      expect(page).not_to have_content('Ruby with RSpec')
      expect(page).to have_content('Ruby on Rails')
      expect(page).to have_content('How to grow up kittens')
    end

    # 2nd page
    click_link '2'
    expect(current_path).to eq blogo_page_path(2)
    within('#main') do
      expect(page).to have_content('Ruby and Vim')
      expect(page).to have_content('Ruby with RSpec')
      expect(page).not_to have_content('Ruby on Rails')
      expect(page).not_to have_content('How to grow up kittens')
    end
  end

  it' shows pages with tags filter' do
    visit blogo_root_path

    # 1st page
    click_link 'ruby'
    expect(current_path).to eq blogo_tag_path('ruby')
    within('#main') do
      expect(page).to have_content('Ruby with RSpec')
      expect(page).to have_content('Ruby on Rails')

      # This one must be on 2nd page
      expect(page).not_to have_content('Ruby and Vim')
      # Kittens are out of "ruby" tag
      expect(page).not_to have_content('How to grow up kittens')
    end

    # 2nd page
    click_link '2'
    expect(current_path).to eq blogo_tag_page_path('ruby', 2)
    within('#main') do
      expect(page).to have_content('Ruby and Vim')

      # These two must be on the 1st page
      expect(page).not_to have_content('Ruby with RSpec')
      expect(page).not_to have_content('Ruby on Rails')

      # Kittens are out of "ruby" tag
      expect(page).not_to have_content('How to grow up kittens')
    end
  end
end
