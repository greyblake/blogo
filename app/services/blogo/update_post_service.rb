module Blogo
  class UpdatePostService < BasePostService
    attr_reader :post

    def initialize(post, params)
      @post        = post
      @tags_string = params.delete(:tags_string)
      @post_attrs  = params
    end

    def update!
      assign_attributes
      return false unless @post.valid?

      @post.transaction do
        clear_tags!
        set_tags!(@tags_string)
        @post.save!
      end

      true
    end
  end
end
