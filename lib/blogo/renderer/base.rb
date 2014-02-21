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
      # @return [void]
      def load_dependencies!
        return unless dependencies

        dependencies.each do |dependency|
          begin
            require dependency[:require]
          rescue LoadError
            msg = "Cannot load such file `#{dependency[:require]}`. " \
                  "Please add `gem '#{dependency[:gem]}' to the Gemfile"
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
