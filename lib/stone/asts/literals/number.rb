require 'stone/asts/leaf'

module Stone
  module AST
    module Literal
      class Number < Leaf
        def value
          token.num
        end

        def eval(_)
          value
        end
      end
    end
  end
end
