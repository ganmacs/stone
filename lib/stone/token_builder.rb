require 'stone/token'

module Stone
  class TokenBuilder
    def build(line_no)
      @line_no = line_no
    end

    def call(m)
      reset(m)
      token.new(@line_no, matched) unless space? || comment?
    end

    private

    def token
      case
      when num?
        Stone::Token::Num
      when str?
        Stone::Token::Str
      else
        Stone::Token::Id
      end
    end

    def matched
      @matched ||= @m[1]
    end

    def comment
      @comment ||= @m[2]
    end

    def num
      @num ||= @m[3]
    end

    def str
      @str ||= @m[4]
    end

    def space?
      matched.nil?
    end

    def comment?
      !!comment
    end

    def num?
      !!num
    end

    def str?
      !!str
    end

    def reset(m)
      @m = m
      @num = nil
      @matched = nil
      @comment = nil
      @str = nil
    end
  end
end
