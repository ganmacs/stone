# Extend basic parser in run time
# Usage:
#
# requre 'extender'
# class BasicParser
#   include Extender
#   ...
# end
#

require 'stone/ast'

module Stone
  module Extender
    def add_extended_rule(op)
      add_operator(op, 2)
      extend_tenary
    end

    def add_operator(name, pre)
      operators.add(name, pre, Stone::Parser::Operators::LEFT)
    end

    def extend_tenary
      extend_tenaryis = rule.expression(factor, operators, Stone::AST::Expression::Binary)
      expression.insert_choice(extend_tenaryis)
    end
  end
end
