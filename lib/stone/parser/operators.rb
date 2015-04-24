require 'stone/parser/precedence'

module Stone
  module Parser
    class Operators
      LEFT = true
      RIGHT = false

      def add(name, precedence, left_associative)
        operators.update(name => Precedence.new(precedence, left_associative))
      end

      def operators
        @operators ||= {}
      end
    end
  end
end
