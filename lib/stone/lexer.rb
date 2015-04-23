require 'stone/token_builder'
require 'stone/token'

module Stone
  class Lexer
    TOKEN = %r{\s*((//.*)|([0-9]+)|("(\"|\\\\|\n|[^\"])*")|[A-Z_a-z][A-Z_a-z0-9]*|==|<=|>=|&&|\|\||=|[=`~$^+|<>[:punct:]])?}

    # @reader LineNumberReader instance
    def initialize(reader)
      @reader = reader
    end

    def read_token
      read_tokens
      token!
    end

    def peek_token(n = 0)
      read_tokens(n = 0)
      token(n)
    end

    def each_token
      loop { read_line }
      tokens.each { |token| yield(token) }
    end

    private

    def read_tokens(n = 0)
      (n + 1).times do
        break if has_tokens?(n)
        read_line
      end
    rescue StopIteration
      nil                       # TODO
    end

    def read_line
      tokens.concat(next_line_tokens)
    end

    def next_line_tokens
      reset

      token_builder.build(line.no)
      [].tap do |tokens|
        i = 0
        while i < line.body.length
          TOKEN.match(line.body, i) do |m|
            i += m[0].size
            tokens << token_builder.call(m)
          end
        end
        tokens << Stone::Token::Id.new(line.no, Token::EOL)
      end
    end

    def token!
      tokens.shift || Token::EOF
    end

    def token(i = 0)
      tokens[i] || Token::EOF
    end

    # has number of tokens?
    def has_tokens?(i = 0)
      tokens.size > i
    end

    def line
      @line ||= @reader.readline
    end

    def token_builder
      @token_builder ||= Stone::TokenBuilder.new
    end

    def tokens
      @tokens ||= []
    end

    def reset
      @line = nil
    end
  end
end
