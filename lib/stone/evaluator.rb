require 'stone/ast'
require 'stone/function'

module Stone
  TRUE = 1
  FALSE = 0
  # Using open class to eval asts
  module AST
    class List
      def eval(_env)
        raise "List #{self}"
      end
    end

    class Leaf
      def eval(_env)
        raise "Leaf #{self}"
      end
    end

    class Name
      def eval(env)
        env[name] or raise "undefined name: #{self}"
      end
    end

    class Fun
      def eval(env)
        Function.new(parameters, body, env)
      end
    end

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

    module Literal
      class Number
        def eval(_env)
          value
        end
      end

      class String
        def eval(_env)
          value
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

      class Negative
        def eval(env)
          -1 * Integer(operand.eval(env))
        rescue
          raise "bad type for - #{self}"
        end
      end

      class Binary
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

        def compute_assign(env, right)
          if left.is_a?(Stone::AST::Name)
            env[left.name] = right
            right
          else
            raise "bad assingment #{self}"
          end
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

    module Statement
      class Defn
        def eval(env)
          env[name] = Stone::Function.new(prameters, body, env)
          name
        end
      end

      class While
        def eval(env)
          result = 0
          loop do
            c = condition.eval(env)
            if c.is_a?(Fixnum) && c == FALSE
              return result
            else
              result = body.eval(env)
            end
          end
        end
      end

      class Block
        def eval(env)
          result = nil
          children.each do |child|
            result = child.eval(env)
          end
          result
        end
      end

      class If
        def eval(env)
          cond = condition.eval(env)
          if cond.is_a?(Fixnum) && cond != FALSE
            then_block.eval(env)
          else
            if has_else_block?
              else_block.elva(env)
            else
              0
            end
          end
        end
      end
    end
  end
end
