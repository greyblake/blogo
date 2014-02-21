module Blogo
  class CreatePostService < BasePostService
    attr_reader :post

    def initialize(user, params)
      @post        = user.posts.build
      @tags_string = params.delete(:tags_string)
      @post_attrs  = params
    end

    def create!
      assign_attributes
      return false unless @post.valid?

      @post.transaction do
        @post.save!
        set_tags!(@tags_string)
      end

      true
    end
  end
end
