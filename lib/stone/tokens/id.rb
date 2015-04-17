require 'stone/tokens/base'

module Stone
  module Token
    class Id < Base
      def initialize(line, id)
        super(line)
        @id = id
      end

      def id?
        true
      end

      def text
        @id
      end
    end
  end
end
