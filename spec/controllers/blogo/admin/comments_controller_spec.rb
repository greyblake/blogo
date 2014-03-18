require 'spec_helper'

describe Blogo::Admin::CommentsController do
  before { login! }

  describe '#index' do
    it 'works ok' do
      get :index
      expect(response).to be_ok
    end
  end
end
