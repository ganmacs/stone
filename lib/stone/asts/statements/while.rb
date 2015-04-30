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

        def eval(env)
          result = 0
          loop do
            c = condition.eval(env)
            if c.is_a?(Fixnum) && c == FALSE
              return result
            else
              result = body.eval(env)
            end
          end
        end
      end
    end
  end
end
