require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Primary < List
        def operand
          children[0]
        end

        def postfix(nest)
          children[number_of_children - nest - 1]
        end

        def eval(env)
          eval_sub_expression(env, 0)
        end

        class << self
          # if has a only child, not create duplicate PrimaryExpr
          def create(c)
            c.size == 1 ? c[0] : Primary.new(c)
          end
        end

        private

        def has_postfix?(nest)
          number_of_children - nest > 1
        end

        def eval_sub_expression(env, nest)
          if has_postfix?(nest)
            target = eval_sub_expression(env, nest + 1) # target = function?
            postfix(nest).eval(env, target)
          else
            operand.eval(env)
          end
        end
      end
    end
  end
end
