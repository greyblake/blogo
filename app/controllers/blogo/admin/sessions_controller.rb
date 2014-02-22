module Blogo::Admin
  class SessionsController < BaseController
    skip_before_filter :ensure_authenticated!

    def new
    end

    def create
      user = Blogo::User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:blogo_user_id] = user.id
        redirect_to admin_url, notice: "You have logged in"
      else
        flash.now.alert = "Incorrect email or password"
        render "new"
      end
    end

    def destroy
      session[:blogo_user_id] = nil
      redirect_to admin_url, notice: "You have logged out"
    end
  end
end
