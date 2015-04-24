require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Repeat < Base
        # onceって微妙
        def initialize(parser, once: false)
          @parser = parser
          @once = once
        end

        def parse(lexer, result)
          while @parser.match?(lexer)
            tree = @parser.parse(lexer) # ast:tree
            if tree.class != AST::List || tree.number_of_children > 0
              result << tree
            end
            break if @once
          end
        end

        def match?(lexer)
          parser.match(lexer)
        end
      end
    end
  end
end
