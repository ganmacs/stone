require 'stone/asts/postfix'

module Stone
  module AST
    class Dot < Postfix
      def name
        children[0].token.text
      end

      def to_s
        ".#{name}"
      end
    end
  end
end
