require 'stone/tokens/base'

module Stone
  module Token
    class Str < Base
      def initialize(line, literal)
        super(line)
        @litral = literal
      end

      def str?
        true
      end

      def text
        @literal
      end
    end
  end
end
