require 'stone/parser/elements/leaf'

module Stone
  module Parser
    module Element
      class Skip < Leaf
        def initialize(token)
          super(token)
        end

        def find(_res, _token)
        end
      end
    end
  end
end
