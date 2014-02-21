module Blogo
  class BasePostService

    private

    def assign_attributes
      @post.assign_attributes(@post_attrs)
      @post.published_at  ||= Time.zone.now
      @post.html_content = Blogo.config.renderer.render(@post.raw_content)
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
    end


    def clear_tags!
      @post.tags.destroy_all.each do |tag|
        tag.destroy if tag.posts.count.zero?
      end
    end

  end
end
