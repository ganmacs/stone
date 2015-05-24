require 'stone/ast'

module Stone
  module LetOpEvaluator
    def eval(env)
      if !env['let_op'].nil? && env['let_op'].key?(operator)
        function = env['let_op'][operator]
        Stone::AST::Arguments.new([left, right]).eval(env, function)
      else
        super(env)
      end
    end
  end
end
