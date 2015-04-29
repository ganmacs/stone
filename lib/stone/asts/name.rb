require 'stone/asts/leaf'

module Stone
  module AST
    class Name < Leaf
      def name
        token.text
      end
    end
  end
end
