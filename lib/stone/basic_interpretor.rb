require 'stone/basic_evaluator'

module Stone
  class BasicInterpretor
    def run(basic_parser, env, lexer)
      while lexer.peek_token != Token::EOF
        ast = basic_parser.parse(lexer)
        p ast.eval(env)
      end
    end
  end
end
