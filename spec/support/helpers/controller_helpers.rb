module ControllerHelpers
  def login_as(user)
    session[:blogo_user_id] = user.id
  end

  def login!
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  def logout!
    session[:blogo_user_id] = nil
  end

  def fixture_image(name)
    File.join(Blogo::Engine.root, 'spec/fixtures/images', name)
  end
end
