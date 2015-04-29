require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class OrTree < Base
        def initialize(*parsers)
          @parsers = parsers
        end

        def parse(lexer)
          parser = choose(lexer)
          raise 'ParseError' if parser.nil?
          parser.parse(lexer)
        end

        def match?(lexer)
          !choose(lexer).nil?
        end

        def choose(lexer)
          @parsers.find { |p| p.match?(lexer) }
        end

        def insert(parser)
          @parsers.unshift(parser)
        end
      end
    end
  end
end
