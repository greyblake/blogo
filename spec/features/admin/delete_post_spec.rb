require 'spec_helper'

describe 'Delete Post' do
  before do
    FactoryGirl.create(:post, title: 'Esperanto en Berlino')
  end

  it 'update post' do
    login!

    expect(page).to have_content("Esperanto en Berlino")
    click_on "delete"

    expect(page).not_to have_content("Esperanto en Berlino")
    expect(Blogo::Post.count).to eq 0
  end
end
