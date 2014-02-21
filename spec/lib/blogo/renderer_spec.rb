require 'spec_helper'

describe Blogo::Renderer do
  describe '.get' do
    it 'initializes renderer' do
      expect(Blogo::Renderer::Html).to receive(:load_dependencies!)
      renderer = Blogo::Renderer.get(:html)
      expect(renderer).to be_a Blogo::Renderer::Html
    end

    it 'raises if there is no renderer for passed format' do
      expect { Blogo::Renderer.get(:fake) }.
        to raise_error(Blogo::Error, "Can't find renderer :fake")
    end
  end
end
