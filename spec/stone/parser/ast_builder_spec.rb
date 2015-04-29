require 'stone/parser/ast_builder'
require 'stone/token'
require 'stone/ast'

describe Stone::Parser::ASTBuilder do
  let(:builder) { described_class.build(klass) }

  describe '#call' do
    context 'received AST inherited class' do
      let(:klass) { Stone::AST::Expression::Binary }
      it 'return recieved class instance' do
        expect(builder.call([])).to be_a Stone::AST::Expression::Binary
      end
    end

    context 'receive class which has create' do
      let(:klass) { Stone::AST::Expression::Primary }
      it 'return args if number of args is 1' do
        expect(builder.call([Stone::Token::Num.new(0, 1)])).to be_a Stone::Token::Num
      end
    end

    context 'receive nil class' do
      let(:klass) { nil }

      context 'return args if number of args is 1' do
        it  { expect(builder.call([Stone::Token::Num.new(0, 1)])).to be_a Stone::Token::Num }
      end

      context 'return args if number of args is not 1' do
        let(:token) { Stone::Token::Num.new(0, 1) }
        it 'return args if number of args is 1' do
          expect(builder.call([token, token])).to be_a Stone::AST::List
        end
      end
    end
  end
end
