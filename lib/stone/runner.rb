require 'stone/lexer'
require 'stone/line_number_reader'
require 'stone/token'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      lexer = Stone::Lexer.new(reader)
      while (token = lexer.read_token) != Token::EOF
        p token
      end
    end

    private

    def reader
      @reader ||= LineNumberReader.new(@file_name)
    end
  end
end
