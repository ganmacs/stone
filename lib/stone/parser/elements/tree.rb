require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Tree < Base
        def initialize(parser)
          @parser = parser
        end

        # @results [ASTree]
        def parse(lexer, results)
          results << @parser.parse(lexer)
        end

        def match?(lexer)
          @parser.match?(lexer)
        end
      end
    end
  end
end
