require 'stone/interpretor'
require 'stone/func_parser'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      interpretor.run(parser, env)
    end

    private

    def interpretor
      @interpretor ||= Stone::Interpretor.new(@file_name)
    end

    def parser
      @parser ||= Stone::FuncParser.new
    end

    def env
      @env ||= Stone::Env.new
    end
  end
end
