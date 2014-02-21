require 'spec_helper'

describe Blogo::Renderer::Base do
  let(:renderer_class) do
    Class.new(described_class) do
      add_dependency :gem => 'gem_name', :require => 'require_file'
    end
  end

  describe '#load_dependencies!' do
    it 'raises if can not load dependency' do
      expect {
        renderer_class.load_dependencies!
      }.to raise_error(LoadError)
    end
  end
end
