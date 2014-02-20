require 'spec_helper'

describe Blogo::DestroyPostService do
  describe '#destroy!' do
    it 'deletes post and remaining tags' do
      post1 = FactoryGirl.create(:post, tags: %w(ruby music rock))
      post2 = FactoryGirl.create(:post, tags: %w(esperanto music))

      described_class.new(post1).destroy!

      expect(Blogo::Post.all).to eq([post2])
      expect(Blogo::Tag.all.map(&:name)). to match_array(%w(esperanto music))
    end
  end
end
