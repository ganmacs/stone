require 'stone/lexer'
require 'stone/line_number_reader'
require 'stone/token'
require 'stone/basic_parser'
require 'stone/basic_interpretor'
require 'stone/envs/basic_env'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      # pp ExprPaser.new(lexer).expression
      # lexer.each_token do |token|
      #   p token
      # end

      # while lexer.peek_token != Token::EOF
      #   ast = basic_parser.parse(lexer)

      #   p ast.to_s
      # end
      basic_interpretor.run(basic_parser, basic_env, lexer)
    end

    private

    def basic_interpretor
      @basic_interpretor ||= Stone::BasicInterpretor.new
    end

    def basic_env
      @basi_env ||= Stone::Env::BasicEnv.new
    end

    def basic_parser
      @basic_parser ||= BasicParser.new
    end

    def lexer
      @lexer ||= Stone::Lexer.new(reader)
    end

    def reader
      @reader ||= LineNumberReader.new(@file_name)
    end
  end
end
