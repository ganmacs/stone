module Stone
  module Parser
    class ASTBuilder
      class << self
        def build(klass)
          ASTBuilder.new(klass)
        end
      end

      def initialize(klass)
        @klass = klass
      end

      def call(result)
        build_by_klass(result) || build_by_tree(result)
      end

      private

      def build_by_klass(result)
        @klass.new(result) unless @klass.nil?
      rescue ArgumentError
        nil
      end

      def build_by_tree(result)
        if result.size == 1
          result[0]
        else
          Stone::AST::List.new(result)
        end
      end
    end
  end
end
