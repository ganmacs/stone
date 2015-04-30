require 'stone/lexer/lexer'
require 'stone/lexer/line_number_reader'

module Stone
  class Interpretor
    def initialize(file_name)
      @file_name = file_name
    end

    def run(parser, env)
      result = []
      while lexer.peek_token != Token::EOF
        ast = parser.parse(lexer)
        result.push(ast.eval(env))
      end
      result
    end

    private

    def lexer
      @lexer ||= Stone::Lexer.new(reader)
    end

    def reader
      @reader ||= LineNumberReader.new(@file_name)
    end
  end
end
