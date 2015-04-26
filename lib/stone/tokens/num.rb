require 'stone/tokens/base'

module Stone
  module Token
    class Num < Base
      attr_reader :value

      def initialize(line, value)
        super(line)
        @value = Integer(value)
      end

      def num?
        true
      end

      def text
        @value.to_s
      end

      def number
        @value
      end
    end
  end
end
