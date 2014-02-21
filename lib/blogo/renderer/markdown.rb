module Blogo::Renderer
  class Markdown < Base
    add_dependency :gem => 'redcarpet', :require => 'redcarpet'

    def initialize
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end

    # :nodoc:
    def render(raw_text)
      @markdown.render(raw_text)
    end
  end
end
