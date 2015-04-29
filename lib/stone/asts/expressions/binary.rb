require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Binary < List
        def left
          children[0]
        end

        def right
          children[2]
        end

        def operator
          children[1].token.text
        end
      end
    end
  end
end
