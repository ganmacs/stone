module Stone
  module Token
    class Base
      attr_reader :line_number

      def initialize(line_number)
        @line_number = line_number
      end

      def id?
        false
      end

      def num?
        false
      end

      def str?
        false
      end

      def num
        raise RuntimeError      # @TODO specific error class
      end

      def text
        ''
      end
    end
  end
end
