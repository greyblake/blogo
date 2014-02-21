require 'blogo/renderer/base'
require 'blogo/renderer/html'
require 'blogo/renderer/markdown'

module Blogo
  module Renderer

    # Maps format names to renderers.
    RENDERERS = {
      :markdown => Blogo::Renderer::Markdown,
      :html     => Blogo::Renderer::Html
    }

    # Find and initialize renderer for a particular markup format.
    #
    # @param format [Symbol, String]
    #
    # @return [Blogo::Renderer::Base]
    def self.get(format)
      if renderer_class = RENDERERS[format.to_sym]
        renderer_class.load_dependencies!
        renderer_class.new
      else
        raise(Blogo::Error, "Can't find renderer #{format.inspect}")
      end
    end

  end
end
