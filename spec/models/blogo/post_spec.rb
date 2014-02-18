require 'spec_helper'

describe Blogo::Post do
  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:url)           }
    it { expect(subject).to validate_presence_of(:title)         }
    it { expect(subject).to validate_presence_of(:raw_content)   }
    it { expect(subject).to validate_presence_of(:html_content)  }
    it { expect(subject).to validate_presence_of(:markup_format) }
    it { expect(subject).to validate_presence_of(:published)     }
    it { expect(subject).to validate_presence_of(:published_on)  }
  end
end
