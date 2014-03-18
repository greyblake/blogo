module Blogo
  class BasePostService
    JUMP_BREAK = '<!--more-->'


    private

    def assign_attributes
      @post.assign_attributes(@post_attrs)
      @post.published_at ||= Time.zone.now
      @post.markup_lang    = Blogo.config.markup_lang
      render_and_set_content!
    end


    def set_tags!(tags_string)
      return unless tags_string.present?

      tag_names = tags_string.split(',').map do |tag_name|
        tag_name.strip.downcase
      end
      tag_names.reject!(&:blank?)

      tag_names.each do |tag_name|
        tag = Blogo::Tag.where(name: tag_name).first_or_create
        @post.tags << tag unless @post.tags.include?(tag)
      end

      @post.tags_string = tag_names.join(", ")
    end

    def clear_tags!
      @post.tags.destroy_all.each do |tag|
        tag.destroy if tag.posts.count.zero?
      end
    end

    def render_and_set_content!
      return unless @post.raw_content

      renderer = Blogo::Renderer.get(Blogo.config.markup_lang)
      overview, rest = @post.raw_content.split(JUMP_BREAK, 2)

      if rest.present?
        @post.html_overiew = renderer.render(overview)
        @post.html_content = renderer.render(overview + rest)
      else
        @post.html_overiew = nil
        @post.html_content = renderer.render(@post.raw_content)
      end
    end
  end
end
