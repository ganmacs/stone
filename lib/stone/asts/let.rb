require 'stone/asts/list'

module Stone
  module AST
    class Let < List
      def args
        raise 'require 2 arguments' if children[0].nil?
        children[0].children
      end

      def name
        args[0]
      end

      def body
        args[1]
      end

      def to_s
        "let(#{name}, #{body})"
      end

      def eval(env)
        env[name.token.text] = body.eval(env)
        nil
      end
    end
  end
end
