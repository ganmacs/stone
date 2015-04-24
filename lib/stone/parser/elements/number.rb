require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Number < Token
        def initialize(type)
          super(type)
        end

        def test(token)
          token.num?
        end
      end
    end
  end
end
