require 'stone/asts/postfix'
# require 'stone/evaluator_extensions/native_evaluator'

module Stone
  module AST
    class Arguments < Postfix
      # prepend NativeEvaluator
      alias_method :size, :number_of_children

      def eval(caller_env, function)
        raise "Bad Function : #{self}" unless function.is_a?(Stone::Function)
        raise "Bad Number of Argument : #{self}" unless size == function.parameters.size

        bind_argument_in_function_env(function, caller_env)
      end

      private

      def bind_argument_in_function_env(function, caller_env)
        new_env = function.make_env
        children.each_with_index do |child, i|
          function.parameters.eval(new_env, i, child.eval(caller_env))
        end
        function.body.eval(new_env)
      end
    end
  end
end
