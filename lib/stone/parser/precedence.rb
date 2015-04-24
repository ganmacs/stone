module Stone
  module Parser
    class Precedence
      attr_reader :value

      def initialize(value, left_associative)
        @value = value
        @left_associative = left_associative
      end

      def left_associative?
        @left_associative
      end
    end
  end
end
