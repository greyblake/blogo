module Blogo::Renderer
  class Html < Base

    # :nodoc:
    def render(raw_text)
      raw_text.dup
    end

  end
end
