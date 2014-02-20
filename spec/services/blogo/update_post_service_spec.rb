require 'spec_helper'

describe Blogo::UpdatePostService do
  let(:params) {{
    title: 'New Title',
    url: 'new-url',
    raw_content: 'New content'
  }}

  let(:post)    { FactoryGirl.create(:post, tags: tags) }
  let(:service) { described_class.new(post, params) }
  let(:tags)    { [] }

  describe '#update!' do

    describe 'with invalid params' do
      before do
        params[:title] = ''
      end

      it 'returns false and sets errors on post' do
        expect(service.update!).to be_false
        expect(service.post).to have(1).error_on(:title)
      end
    end

    describe 'with tags' do
      before do
        params[:tags_string] = 'ruby, esperanto'
      end

      let(:tags) { %w(ruby music) }

      it 'assigns new tags and removes old' do
        # Create post and tags
        post

        # ensure old tags exist
        expect(Blogo::Tag.all.map(&:name)).to match_array(%w(ruby music))

        expect(service.update!).to be_true

        post.reload
        expect(post.tags.map(&:name)).to match_array(%w[ruby esperanto])

        # Make sure "music" tag is removed since there are no posts with it anymore
        expect(Blogo::Tag.all.map(&:name)).to match_array(%w(ruby esperanto))
      end


      it 'does not removes tag completely if there other posts refer it' do
        FactoryGirl.create(:post, tags: %w(music))
        expect(service.update!).to be_true
        expect(Blogo::Tag.all.map(&:name)).
          to match_array(%w(ruby esperanto music))
      end
    end
  end
end
