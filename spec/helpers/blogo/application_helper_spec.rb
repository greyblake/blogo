require 'spec_helper'

describe Blogo::ApplicationHelper do
  describe '#path_to_post' do
    it 'generates path to post with year' do
      post = FactoryGirl.create(:post, permalink: 'new-year')
      expect(helper).to receive(:post_path).with(permalink: 'new-year')
      helper.path_to_post(post)
    end
  end

  describe '#path_to_page' do
    it 'generates path to page' do
      expect(helper).to receive(:page_path).with(10)
      helper.path_to_page(10)
    end

    it 'generates path to tag with page if tag is passed' do
      expect(helper).to receive(:tag_page_path).with('tag', 12)
      helper.path_to_page(12, 'tag')
    end
  end
end
