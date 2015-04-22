require 'stone/ast/base'

module Stone
  module AST
    class Leaf < Base
      def initialize(token)
        @token = token
      end

      def child
        nil
      end

      def number_of_children
        0
      end

      def children
        []
      end

      def to_s
        @token.text
      end

      def location
        "at line #{@token.line_number}"
      end

      def token
        @token
      end
    end
  end
end
