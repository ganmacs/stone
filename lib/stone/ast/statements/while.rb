require 'stone/ast/list'

module Stone
  module AST
    module Statement
      class While < List
        def initialize(children)
          super(children)
        end

        def condition
          child(0)
        end

        def body
          child(1)
        end

        def to_s
          "(while #{condition} #{body})"
        end
      end
    end
  end
end
