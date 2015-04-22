require 'stone/ast/leaf'

module Stone
  module AST
    module Literal
      class Number < Leaf
        def initialize(token)
          super(token)
        end

        def value
          token.number
        end
      end
    end
  end
end
