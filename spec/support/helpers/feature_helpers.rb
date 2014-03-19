module FeatureHelpers
  def login!
    FactoryGirl.create(:user, email: 'admin@mail.com', password: 'sekreto')

    visit blogo_admin_login_path

    fill_in 'email'   , with: 'admin@mail.com'
    fill_in 'password', with: 'sekreto'
    click_button 'Login'
  end
end
