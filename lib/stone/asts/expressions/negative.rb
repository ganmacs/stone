require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Negative < List
        def initialize(children)
          super(children)
        end

        def operand
          child(0)
        end

        def to_s
          "- #{operand}"
        end
      end
    end
  end
end
