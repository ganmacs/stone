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

        next if env['let_op'].nil?
        env['let_op'].reject { |k, _| in?(k) }.each do |k, _|
          added_op << k
          parser.add_extended_rule(k)
        end
      end
      result
    end

    private

    def in?(key)
      added_op.include?(key)
    end

    def added_op
      @added_op ||= []
    end

    def lexer
      @lexer ||= Stone::Lexer.new(reader)
    end

    def reader
      @reader ||= LineNumberReader.new(@file_name)
    end
  end
end
