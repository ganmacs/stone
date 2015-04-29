require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Repeat < Base
        def initialize(parser, once: false)
          @parser = parser
          @once = once
        end

        def parse(lexer)
          results = []
          while @parser.match?(lexer)
            tree = @parser.parse(lexer)
            results << tree if leaf?(tree)
            break if @once
          end
          results
        end

        def match?(lexer)
          parser.match?(lexer)
        end

        private

        def leaf?(tree)
          tree.class != AST::List || tree.number_of_children > 0
        end
      end
    end
  end
end
