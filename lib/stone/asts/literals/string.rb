require 'stone/asts/leaf'

module Stone
  module AST
    module Literal
      class String < Leaf
        def value
          token.text
        end

        def eval(_)
          value
        end
      end
    end
  end
end
