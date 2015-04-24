require 'stone/parser/elements/token'

module Stone
  module Parser
    module Element
      class Id < Token
        def initialize(type, reserved)
          super(type)
          @reserved = reserved
        end

        def test(token)
          token.id? && !reserved.include?(token.text)
        end

        def reserved
          @reserved || Set.new
        end
      end
    end
  end
end
