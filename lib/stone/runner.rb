require 'stone/lexer'
require 'stone/line_number_reader'
require 'stone/token'

require 'stone/closure_interpretor'
require 'stone/closure_parser'
require 'stone/envs/nested_env'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      interpretor.run(parser, env, lexer)
    end

    private

    def interpretor
      @interpretor ||= Stone::ClosureInterpretor.new
    end

    def parser
      @parser ||= Stone::ClosureParser.new
    end

    def env
      @env ||= Stone::Env::NestedEnv.new
    end

    def lexer
      @lexer ||= Stone::Lexer.new(reader)
    end

    def reader
      @reader ||= LineNumberReader.new(@file_name)
    end
  end
end
