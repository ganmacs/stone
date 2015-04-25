require 'stone/parser/ast_builder'
require 'stone/ast'

describe Stone::Parser::ASTBuilder do
  describe 'build' do
    context 'received AST inherited class' do
      let(:builder) { described_class.ast_list(Stone::AST::Expression::Binary) }
      it 'return recieved class instance' do
        expect(builder.build([])).to be_a Stone::AST::Expression::Binary
      end
    end
  end
end
