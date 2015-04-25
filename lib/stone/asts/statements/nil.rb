require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class Nil < List
        def initialize(children)
          super(children)
        end
      end
    end
  end
end
