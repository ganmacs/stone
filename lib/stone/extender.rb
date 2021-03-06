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
      extend_binary
    end

    def add_operator(name, pre)
      operators.add(name, pre, Stone::Parser::Operators::LEFT)
    end

    def extend_binary
      extend_binary = rule.expression(factor, operators, Stone::AST::Expression::Binary)
      expression.insert_choice(extend_binary)
    end
  end
end
