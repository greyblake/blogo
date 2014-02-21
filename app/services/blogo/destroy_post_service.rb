module Blogo
  class DestroyPostService < BasePostService
    def initialize(post)
      @post = post
    end

    def destroy!
      clear_tags!
      @post.destroy!
      true
    end
  end
end
