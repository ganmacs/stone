require 'stone/function'
require 'stone/ast'

module Stone
  module AST
    class LetOp < List

      def op
        args[0].children[1].token.text
      end

      def fun_args
        [args[0].children[0]] + args[0].children[2..-1]
      end

      def body
        args[1]
      end

      def to_s
        "let_op(#{name}, #{body})"
      end

      def eval(env)
        env['let_op'] ||= {}
        env['let_op'][op] = Stone::Function.new(Stone::AST::ParameterList.new(fun_args),
                                                body,
                                                env)
        nil
      end

      private

      def args
        @args ||= begin
          raise 'require 2 arguments' if children[0].nil?
          children[0].children
        end
      end
    end
  end
end
