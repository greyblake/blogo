require 'spec_helper'

RSpec.describe Blogo::Post do
  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to have_many(:taggings) }
    it { expect(subject).to have_many(:tags)     }
  end

  describe 'validations' do
    before do
      # to have existing records in DB to test uniqueness validation
      FactoryGirl.create(:post)
    end

    it { expect(subject).to validate_presence_of(:permalink)     }
    it { expect(subject).to validate_presence_of(:title)         }
    it { expect(subject).to validate_presence_of(:raw_content)   }
    it { expect(subject).to validate_uniqueness_of(:permalink)   }
  end


  describe '#set_meta_description' do
    it 'removes HTML tags' do
      post = FactoryGirl.create(:post, html_content: '<h1>Article</h1><p>Is really <strong>cool</strong></p>')
      expect(post.meta_description).to eq 'Article Is really cool'
    end
  end

  describe '#meta_image' do
    it 'gets image src in single quotes' do
      post = FactoryGirl.create(:post, html_content: "<p><img src='/img.png' /></p>")
      expect(post.meta_image).to eq "/img.png"
    end

    it 'gets image src in double quotes' do
      post = FactoryGirl.create(:post, html_content: '<p><img src="/img.png" /></p>')
      expect(post.meta_image).to eq "/img.png"
    end

    it 'returns nil if image is not found' do
      post = FactoryGirl.create(:post, html_content: '<p></p>')
      expect(post.meta_image).to be_nil
    end
  end
end
