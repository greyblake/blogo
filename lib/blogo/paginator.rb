module Blogo
  # Does main calculation for pagination.
  #
  # @example
  #   # Current page is 3
  #   paginator = Paginator.new(Post.all, page: 4, per_page: 3, size: 5)
  #
  #   # Displays 5 pages, since size = 5
  #   paginator.pages # => [2, 3, 4, 5, 6]
  #
  #   # Previous page <<
  #   paginator.prev_page # => 1
  #
  #   # Next page >>
  #   paginator.prev_page # => 7
  #
  #   # Get items for the current page
  #   paginator.items  # => 3 posts
  #
  class Paginator
    attr_reader :page

    # :nodoc:
    DEFAULT_PER_PAGE = 10

    # :nodoc:
    DEFAULT_PAGE     = 1

    # :nodoc:
    DEFAULT_SIZE     = 5

    # @param relation [ActiveRecord::Realtion]
    # @param opts [Hash]
    # @option opts :per_page [Integer] number of items display on 1 page
    # @option opts :page [Integer] current page number
    # @option opts :size [Integer] number of pages displayed with paginator
    def initialize(relation, opts = {})
      @relation = relation
      @per_page = (opts[:per_page] || DEFAULT_PER_PAGE).to_i
      @page     = (opts[:page]     || DEFAULT_PAGE).to_i
      @size     = (opts[:size]     || DEFAULT_SIZE).to_i
    end

    # Fetch items for the current page.
    #
    # @return [Array<ActiveRecord::Base>]
    def items
      @items ||= begin
        offset = @per_page * (@page - 1)
        @relation.limit(@per_page).offset(offset)
      end
    end

    # Number of pages to display.
    #
    # @return [Array<Integer>]
    def pages
      @pages ||= begin
        from = @page - (@size / 2).ceil
        from = 1 if from < 1
        upto = from + @size - 1

        # Correct +from+ and +to+ if +to+ is more than number of pages
        if upto > pages_count
          from -= (upto - pages_count)
          from = 1 if from < 1
          upto = pages_count
        end

        (from..upto).to_a
      end
    end

    # Previous page number. Is used for << link.
    #
    # @return [Integer, nil]
    def prev_page
      first_page = pages.first.to_i
      first_page > 1 ? (first_page - 1) : nil
    end


    # Next page number. I used for >> link.
    #
    # @return [Integer, nil]
    def next_page
      if pages.any? && pages_count > pages.last
        pages.last + 1
      else
        nil
      end
    end


    private

    # Number all existing pages.
    #
    # @return [Integer]
    def pages_count
      @pages_count ||= (items_count / @per_page.to_f).ceil
    end

    # Number of all existing items.
    #
    # @return [Integer]
    def items_count
      @items_count ||= @relation.count
    end
  end
end
