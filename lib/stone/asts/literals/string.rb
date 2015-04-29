require 'stone/asts/leaf'

module Stone
  module AST
    module Literal
      class String < Leaf
        def value
          token.text
        end
      end
    end
  end
end
