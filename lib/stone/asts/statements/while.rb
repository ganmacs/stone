require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class While < List
        def condition
          children[0]
        end

        def body
          children[1]
        end

        def to_s
          "(while #{condition} #{body})"
        end
      end
    end
  end
end
