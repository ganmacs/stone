require 'stone/ast'
require 'stone/token'

module Stone
  module ClassParser
    def initialize
      super
      postfix.insert_choice(instance_fun)
      program.insert_choice(defclass)
    end

    def instance_fun
      rule(Dot.class(Stone::AST::Dot).sep('.').identifier(reserved))
    end

    # <member> ::= <defn> | <simple>
    def member
      @member ||= rule.or(defn, simple)
    end

    # <class_body> ::= "{" <member> { (";" | EOL) } "}"
    def class_body
      @class_body ||= rule(Stone::AST::ClassBody).sep('{')
                    .option(member)
                    .repeat(rule.sep(';', Token.EOL).option(member))
                    .sep('}')
    end

    # <defclass> ::= "class" IDENTIFIER [ "extends" IDENTIFIER ] class_body
    def defclass
      rule(Stone::AST::Statement::Class).sep('class').identifier(reserved)
        .option(rule.sep('extends').identifier(reserved))
        .ast(class_body)
    end
  end
end
