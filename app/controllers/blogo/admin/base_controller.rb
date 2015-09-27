module Blogo::Admin
  class BaseController < Blogo::ApplicationController
    before_action :ensure_authenticated!

    layout 'blogo/admin'


    private

    def ensure_authenticated!
      redirect_to blogo_admin_login_path unless blogo_current_user
    end

    def blogo_current_user
      @blogo_current_user ||= Blogo::User.find(session[:blogo_user_id]) if session[:blogo_user_id]
    end
    helper_method :blogo_current_user
  end
end
