require 'stone/lexer'
require 'stone/line_number_reader'
require 'stone/token'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      # pp ExprPaser.new(lexer).expression
      lexer.each_token do |token|
        p token
      end
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
