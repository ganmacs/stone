require 'stone/asts/list'

module Stone
  module AST
    class Fun < List
      def parameters
        children[0]
      end

      def body
        children[1]
      end

      def to_s
        "(fun #{parameters} #{body})"
      end
    end
  end
end
