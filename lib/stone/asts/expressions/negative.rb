require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Negative < List
        def operand
          children[0]
        end

        def to_s
          "- #{operand}"
        end
      end
    end
  end
end
