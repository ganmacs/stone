require 'stone/func_evaluator'

module Stone
  module AST
    class Fun
      def eval(env)
        Stone::Function.new(parameters, body, env)
      end
    end
  end
end
