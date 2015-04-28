require 'stone/evaluator'

module Stone
  class BasicInterpretor
    def run(basic_parser, env, lexer)
      result = []
      while lexer.peek_token != Token::EOF
        ast = basic_parser.parse(lexer)
        result.push(ast.eval(env))
      end
      result
    end
  end
end
