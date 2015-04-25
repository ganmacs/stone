module Stone
  module Parser
    class ASTBuilder
      attr_writer :build_ast

      # @return AST
      def build(results)
        build_ast(results)
      end

      def build_ast(results)
        # 多分invalid argument的なのがraiseしそうなきもする
        @build_ast.call(results)
      end

      # astlistかastleafを継承している何かを返す
      # klassがnilならAstList
      # klassはPaserかAST::Baseを継承した何かが来るはずきっとまたはnil
      class << self
        def ast_list(klass)
          factory = get(klass)
          if factory.nil?
            factory = new.tap do |builder|
              builder.build_ast = lambda do |result|
                if result.size == 1
                  result[0]
                else
                  Stone::AST::List.new(result)
                end
              end
            end
          end
          factory
        end

        def get(klass)
          return if klass.nil?
          new.tap do |builder|
            builder.build_ast = lambda do |result|
              if klass.respond_to?(:create)
                klass.create(result)
              else
                klass.new(result)
              end
            end
          end
        rescue ArgumentError
          # nothing
        end
      end
    end
  end
end
