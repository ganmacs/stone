require 'stone/ast/leaf'

module Stone
  module AST
    class Name < Leaf
      def initialize(token)
        super(token)
      end

      def name
        token.text
      end
    end
  end
end
