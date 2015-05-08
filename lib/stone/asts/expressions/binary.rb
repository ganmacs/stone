require 'stone/asts/list'
require 'stone/evaluator_extensions/class_evaluator'
require 'stone/evaluator_extensions/array_evaluator'

module Stone
  module AST
    module Expression
      class Binary < List
        prepend ClassEvaluator
        prepend ArrayEvaluator

        def left
          children[0]
        end

        def right
          children[2]
        end

        def operator
          children[1].token.text
        end

        def eval(env)
          if operator == '='
            evaled_right = right.eval(env)
            compute_assign(env, evaled_right)
          else
            evaled_left = left.eval(env)
            evaled_right = right.eval(env)
            compute_operand(evaled_left, operator, evaled_right)
          end
        end

        private

        def compute_assign(env, right)
          if left.is_a?(Stone::AST::Name)
            env[left.name] = right
            right.is_a?(Fixnum) ? right : right.dup
          else
            raise "bad assingment #{self}"
          end
        end

        def set_field(obj, expression, value)
          name = expression.name
          obj.write(name, value)
          value
        rescue NameError
          raise "Bad member access #{location} : #{name}"
        end

        def compute_operand(left, op, right)
          if left.is_a?(Fixnum) && right.is_a?(Fixnum)
            compute_number(left, op, right)
          else
            case op
            when '+'
              String(left) + String(right)
            when '=='
              compute_equal(left, right)
            else
              raise "bad type #{self}"
            end
          end
        end

        def compute_number(left, op, right)
          case op
          when '+' then left + right
          when '-' then left - right
          when '*' then left * right
          when '/' then left / right
          when '%' then left % right
          when '>' then left > right ? TRUE : FALSE
          when '<' then left < right ? TRUE : FALSE
          when '==' then left == right ? TRUE : FALSE
          else
            raise "bad operator #{self}"
          end
        end

        def compute_equal(left, right)
          if left.nil?
            right.nil? ? TRUE : FALSE
          else
            left == right ? TRUE : FALSE
          end
        end
      end
    end
  end
end
