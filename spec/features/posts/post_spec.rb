require 'spec_helper'

describe 'Post', type: :feature do
  let(:overview) { "Should we learn Esperanto?" }
  let(:content)  { "Should we learn Esperanto? Of course yes! It's much easier than English and much more powerful!" }
  before do
    FactoryGirl.create(:post,
      permalink: 'learn-esperanto',
      html_overview: overview,
      html_content: content,
    )
  end

  it 'shows posts overview on the blog page' do
    visit blogo_root_path

    expect(page).to have_content(overview)
    expect(page).not_to have_content(content)
  end

  it 'shows post content' do
    visit blogo_root_path
    click_link 'Read'

    expect(current_path).to eq '/blog/learn-esperanto'
    expect(page).to have_content(content)
  end
end
