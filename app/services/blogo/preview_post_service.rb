module Blogo
  # Creates new model of posts applying post params on it so it can be previewed.
  class PreviewPostService < BasePostService

    # @param user [Blogo::User]
    # @param params [Hash]
    def initialize(user, params)
      @post        = user.posts.build
      @post_attrs  = params
    end

    # Assign post attributes and return a post.
    #
    # @return [Blogo::Post]
    def preview
      assign_attributes
      @post
    end
  end
end
