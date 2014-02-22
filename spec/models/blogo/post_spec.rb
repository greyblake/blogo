require 'spec_helper'

describe Blogo::Post do
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

    it { expect(subject).to validate_presence_of(:url)           }
    it { expect(subject).to validate_presence_of(:title)         }
    it { expect(subject).to validate_presence_of(:raw_content)   }
    it { expect(subject).to validate_uniqueness_of(:url) }
  end
end
