require 'spec_helper'

describe Blogo::CreatePostService do
  let(:params) {{
    title: 'The Title',
    url: 'the-url',
    raw_content: 'The content'
  }}

  let(:user)    { FactoryGirl.create(:user) }
  let(:service) { described_class.new(user, params) }

  describe '#create!' do
    it 'creates a post' do
      expect(service.create!).to be_true

      post = user.posts.last
      expect(post.title).to eq 'The Title'
      expect(post.url).to eq 'the-url'
      expect(post.raw_content).to eq 'The content'
      expect(post.html_content).to eq 'The content'
      expect(post.html_overiew).to be_nil
    end

    describe 'with tags' do
      before do
        params[:tags_string] = ' Ruby, Esperanto, , love '
      end

      it 'creates downcased tags and associates them with post' do
        expect(service.create!).to be_true

        post = user.posts.last
        tag_names = post.tags.map(&:name)
        expect(tag_names).to match_array(%w[ruby esperanto love])
      end
    end

    describe 'with invalid params' do
      before do
        params[:title] = ''
      end

      it 'returns false and sets errors on post' do
        expect(service.create!).to be_false
        expect(Blogo::Post.count).to eq 0
        expect(service.post).to have(1).error_on(:title)
      end
    end


    describe 'with jump break <!--more-->' do
      before do
        params[:raw_content] = 'Prelude... <!--more--> The content'
      end

      it 'sets html_overiew' do
        expect(service.create!).to be_true
        post = user.posts.last

        expect(post.html_content).to eq 'Prelude...  The content'
        expect(post.html_overiew).to eq 'Prelude... '
      end
    end
  end
end
