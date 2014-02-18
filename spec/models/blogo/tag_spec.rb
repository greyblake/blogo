require 'spec_helper'

describe Blogo::Tag do
  describe 'associations' do
    it { expect(subject).to have_many(:taggings) }
    it { expect(subject).to have_many(:posts)    }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
  end
end
