require 'spec_helper'

describe Blogo::PreviewPostService do
  let(:user) { FactoryGirl.create(:user) }
  let(:params) {{
    raw_content: '<p>Content</p>',
    title: 'The Title',
    tags_string: 'unu, du, tri'
  }}

  describe '#preview' do
    it 'assigns attributes' do
      post = described_class.new(user, params).preview

      expect(post.html_content).to eq '<p>Content</p>'
      expect(post.title).to eq 'The Title'
      expect(post.tag_names).to eq %w(unu du tri)
    end

    it 'does not create new posts' do
      expect {
        described_class.new(user, params).preview
      }.not_to change{Blogo::Post.count}
    end

    it 'does not create new tags' do
      expect {
        described_class.new(user, params).preview
      }.not_to change{Blogo::Tag.count}
    end
  end
end
