require 'spec_helper'

describe Blogo::Admin::SessionsController do
  describe '#new' do
    it 'works ok' do
      get :new
      expect(response).to be_ok
    end
  end

  describe '#create' do
    before do
      FactoryGirl.create(:user, email: 'user@mail.com', password: 'secret13', id: 1230)
    end

    context 'password matches' do
      it 'sets :blogo_user_id in session' do
        post :create, email: 'user@mail.com', password: 'secret13'

        expect(response).to redirect_to blogo_admin_url
        expect(flash[:notice]).to eq "You have logged in"
        expect(session[:blogo_user_id]).to eq 1230
      end
    end

    context 'password does not match' do
      it 'sets flash message' do
        post :create, email: 'user@mail.com', password: 'wrong'

        expect(response).to be_ok
        expect(flash[:alert]).to eq "Incorrect email or password"
        expect(session[:blogo_user_id]).to be_nil
      end
    end
  end

  describe '#logout' do
    it 'resets session[:blogo_user_id]' do
      session[:blogo_user_id] = 19
      get :destroy

      expect(session[:blogo_user_id]).to be_nil
      expect(response).to redirect_to(blogo_admin_url)
      expect(flash[:notice]).to eq "You have logged out"
    end
  end
end
