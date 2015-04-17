require 'stone/token_builder'

module Stone
  class Lexer
    TOKEN = %r{\s*((//.*)|([0-9]+)|("(\"|\\\\|\n|[^\"])*")|[A-Z_a-z][A-Z_a-z0-9]*|==|<=|>=|&&|\|\||=|[=`~$^+|<>[:punct:]])?}

    def initialize(content)
      @content = content
    end

    def read
      @content.flat_map do |line|
        read_line line
      end
    end

    def peek(i)
      @content.take(i).flat_map do |line|
        read_line line
      end
    end

    private

    # return [Token]
    # "adf = 123" => [Token::Str, Token::Id, Token::Num]
    def read_line(line)
      line_no, content = line
      token_builder.build(line_no)

      [].tap do |tokens|
        i = 0
        while content.size > i
          TOKEN.match(content, i) do |m|
            i += m[0].size
            tokens << token_builder.call(m)
          end
        end
      end
    end

    def token_builder
      @token_builder ||= Stone::TokenBuilder.new
    end
  end
end
