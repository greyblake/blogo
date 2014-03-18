module Blogo
  # Note, +_path+ postfix is avoided to not mess helper methods and routes.
  module ApplicationHelper
    include Rails.application.routes.url_helpers

    # Path to a post with year prefix.
    #
    # @param post [Blogo::Post]
    #
    # @return [String]
    def path_to_post(post)
      blogo_post_path(:permalink => post.permalink)
    end

    def url_to_post(post)
      blogo_post_url(:permalink => post.permalink)
    end

    # Path to a page or a page in scope of a particular tag.
    #
    # @param page [Integer]
    # @param tag [String, nil]
    #
    # @retun [String]
    def path_to_page(page, tag = nil)
      if tag
        blogo_tag_page_path(tag, page)
      else
        blogo_page_path(page)
      end
    end

    # Post overview.
    #
    # @param post [Blogo::Post]
    #
    # @return [String]
    def post_overview(post)
      post.html_overview ? post.html_overview : post.html_content
    end
  end
end
