require 'stone/asts/postfix'

module Stone
  module AST
    class ArrayRef < Postfix
      def index
        children[0]
      end

      def to_s
        "[#{index}]"
      end

      def eval(env, value)
        if value.is_a?(Array)
          i = index.eval(env)
          return value[Integer(i)]
        end
        raise ArgumentError
      rescue ArgumentError => e
        raise "Bad Array Access : #{e}"
      end
    end
  end
end
