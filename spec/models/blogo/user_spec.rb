require 'spec_helper'

describe Blogo::User do
  describe 'associations' do
    it { expect(subject).to have_many :posts }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:password).on(:create) }
    it { expect(subject).to validate_presence_of(:name)                 }
    it { expect(subject).to validate_presence_of(:email)                }

    # Does't work because of password_digest
    #it { expect(subject).to validate_uniqueness_of(:email) }

    it 'validates uniqueness of email' do
      FactoryGirl.create(:user, email: 'test@mail.com')
      user = described_class.new(email: 'test@mail.com')

      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
