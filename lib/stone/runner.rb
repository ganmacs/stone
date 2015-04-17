require 'stone/lexer'

module Stone
  class Runner
    def initialize(file_name)
      @file_name = file_name
    end

    def call
      Stone::Lexer.new(file).read
    end

    private

    def file
      @file ||= open_file
    end

    def open_file
      open(@file_name).map.with_index do |line, i|
        [i, line.strip]
      end
    end
  end
end
