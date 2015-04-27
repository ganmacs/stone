require 'stone/lexer'
require 'stone/line_number_reader'
require 'stone/token'

require 'stone/func_interpretor'
require 'stone/func_parser'
require 'stone/envs/nested_env'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      func_interpretor.run(func_parser, nested_env, lexer)
    end

    private

    def func_interpretor
      @func_interpretor ||= Stone::FuncInterpretor.new
    end

    def func_parser
      @func_parser ||= Stone::FuncParser.new
    end

    def nested_env
      @nested_env ||= Stone::Env::NestedEnv.new
    end

    def lexer
      @lexer ||= Stone::Lexer.new(reader)
    end

    def reader
      @reader ||= LineNumberReader.new(@file_name)
    end
  end
end
