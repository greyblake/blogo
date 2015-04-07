module Blogo::Renderer
  class Base
    class << self
      # @!attribute [rw] dependencies
      #   @return [Array<Hash>]
      attr_accessor :dependencies

      # Declare external gem dependencies for a render.
      #
      # @param dependency [Hash] hash with :gem and :require keys
      #
      # @return [void]
      def add_dependency(dependency)
        self.dependencies ||= []
        self.dependencies << dependency
      end

      # Try to load dependencies, otherwise raise meaningful error.
      #
      # @param renderer_name [Symbol, String]
      #
      # @return [void]
      def load_dependencies!(renderer_name)
        return unless dependencies

        dependencies.each do |dependency|
          begin
            require dependency[:require]
          rescue LoadError
            msg = "Please add `gem \"#{dependency[:gem]}\"` to the Gemfile " \
                  "to use Blogo with #{renderer_name.inspect} renderer"
            raise LoadError, msg
          end
        end
      end
    end


    # @param raw_text [String]
    #
    # @return [String] html
    def render(raw_text)
      raise AbstractMethodCallError, __method__
    end
  end
end
