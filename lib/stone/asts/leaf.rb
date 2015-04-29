require 'stone/asts/base'

module Stone
  module AST
    class Leaf < Base
      attr_reader :token

      def initialize(token)
        @token = token
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
    end
  end
end
