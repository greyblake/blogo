require 'spec_helper'

describe 'Login' do
  before do
    FactoryGirl.create(:user, email: 'admin@mail.com', password: 'sekreto')
  end

  it 'is redirected if is not logged in' do
    visit blogo_admin_path
    expect(current_path).to eq blogo_admin_login_path
  end

  it 'can login and logout' do
    visit blogo_admin_login_path

    fill_in 'email'   , with: 'admin@mail.com'
    fill_in 'password', with: 'sekreto'
    click_button 'Login'

    expect(current_path).to eq blogo_admin_path
    expect(page).to have_content 'You have logged in'

    click_link 'Sign out'
    expect(current_path).to eq blogo_admin_login_path
    expect(page).to have_content 'You have logged out'
  end
end
