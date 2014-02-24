require 'spec_helper'

describe Blogo::PostsController do
  render_views

  before do
    @routes = Blogo::Engine.routes
  end

  describe '#feed' do
    it 'renders atom feed' do
      FactoryGirl.create(:post, title: 'How do you do?')
      FactoryGirl.create(:post, title: 'Sleeping in hijacked car')

      get  :feed, format: 'atom'

      expect(response).to be_success
      expect(@response.content_type).to eq 'application/atom+xml'
      expect(@response.body).to include('How do you do?')
      expect(@response.body).to include('Sleeping in hijacked car')
    end
  end
end
