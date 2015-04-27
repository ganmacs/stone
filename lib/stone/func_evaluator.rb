require 'stone/basic_evaluator'
require 'stone/function'

module Stone
  module AST
    class Arguments
      def eval(caller_env, function)
        raise 'bad function' unless function.is_a?(Stone::Function)
        params = function.parameters
        raise 'bad number of argument' unless size == params.size
        new_env = function.make_env
        children.each_with_index do |child, i|
          params.eval(new_env, i, child.eval(caller_env))
        end
        function.body.eval(new_env)
      end
    end

    class ParameterList
      def eval(env, i, value)
        env.update_new(name(i), value)
      end
    end

    module Statement
      class Defn
        def eval(env)
          env[name] = Stone::Function.new(prameters, body, env)
          name
        end
      end
    end

    module Expression
      class Primary
        def eval(env)
          eval_sub_expression(env, 0)
        end

        def eval_sub_expression(env, nest)
          if has_postfix?(nest)
            target = eval_sub_expression(env, nest + 1)
            postfix(nest).eval(env, target)
          else
            operand.eval(env)
          end
        end
      end
    end
  end
end
