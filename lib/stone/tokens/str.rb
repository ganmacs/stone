require 'stone/tokens/base'

module Stone
  module Token
    class Str < Base
      def initialize(line, str)
        super(line)
        @literal = to_literal(str)
      end

      def str?
        true
      end

      def text
        @literal
      end

      private

      def to_literal(str)
        str.gsub(/\"/, '')
      end
    end
  end
end
