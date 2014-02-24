module Blogo
  # Note, +_path+ postfix is avoided to not mess helper methods and routes.
  module ApplicationHelper
    # Path to a post with year prefix.
    #
    # @param post [Blogo::Post]
    #
    # @return [String]
    def path_to_post(post)
      post_path(:year => post.published_at.year, :post_url => post.url)
    end

    def url_to_post(post)
      post_url(:year => post.published_at.year, :post_url => post.url)
    end

    # Path to a page or a page in scope of a particular tag.
    #
    # @param page [Integer]
    # @param tag [String, nil]
    #
    # @retun [String]
    def path_to_page(page, tag = nil)
      if tag
        tag_page_path(tag, page)
      else
        page_path(page)
      end
    end

    # Post overview.
    #
    # @param post [Blogo::Post]
    #
    # @return [String]
    def post_overview(post)
      post.html_overiew ? post.html_overiew : post.html_content
    end
  end
end
