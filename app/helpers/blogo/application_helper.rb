module Blogo
  module ApplicationHelper
    def full_post_path(post)
      post_path(:year => post.published_at.year, :post_url => post.url)
    end
  end
end
