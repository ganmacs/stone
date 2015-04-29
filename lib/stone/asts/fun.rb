require 'stone/asts/list'

module Stone
  module AST
    class Fun < List
      def parameters
        child(0)
      end

      def body
        child(1)
      end

      def to_s
        "(fun #{parameters} #{body})"
      end
    end
  end
end
