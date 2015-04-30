require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Negative < List
        def operand
          children[0]
        end

        def to_s
          "- #{operand}"
        end

        def eval(env)
          -1 * Integer(operand.eval(env))
        rescue
          raise "Bad Type For - #{self}"
        end
      end
    end
  end
end
