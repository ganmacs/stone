require 'stone/ast/leaf'

module Stone
  module AST
    module Literal
      class String < Leaf
        def initialize(token)
          super(token)
        end

        def value
          token.text
        end
      end
    end
  end
end
