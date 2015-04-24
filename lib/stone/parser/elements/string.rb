require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class String < Token
        def initialize(type)
          super(type)
        end

        def test(token)
          token.str?
        end
      end
    end
  end
end
