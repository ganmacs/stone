require 'stone/evaluator'

module Stone
  class Interpretor
    def run(parser, env, lexer)
      result = []
      while lexer.peek_token != Token::EOF
        ast = parser.parse(lexer)
        result.push(ast.eval(env))
      end
      result
    end
  end
end
