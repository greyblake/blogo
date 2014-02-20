require 'spec_helper'

describe Blogo::Post do
  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to have_many(:taggings) }
    it { expect(subject).to have_many(:tags)     }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:url)           }
    it { expect(subject).to validate_presence_of(:title)         }
    it { expect(subject).to validate_presence_of(:raw_content)   }
  end
end
