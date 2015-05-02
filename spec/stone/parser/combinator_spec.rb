require 'stone/lexer/lexer'
require 'stone/lexer/line_number_reader'
require 'stone/parser/combinator'
require 'stone/parser/precedence'
require 'stone/parser/operators'
require 'stone/ast'
require 'stone/token'
require 'set'

describe Stone::Parser::Combinator do
  let(:reader) { Stone::LineNumberReader.new(file) }
  let(:lexer) { Stone::Lexer.new(reader) }
  let(:operator) do
    Stone::Parser::Operators.new.tap do |ope|
      ope.add('=', 1, false)
      ope.add('+', 3, true)
    end
  end

  describe 'Combinator' do
    include Stone::Parser::Helper

    let(:neg_primary) do
      rule(Stone::AST::Expression::Negative)
        .sep('-')
        .number(Stone::AST::Literal::Number)
    end

    let(:expression) do
      rule.expression(rule.or(rule.number(Stone::AST::Literal::Number),
                              rule.identifier(Set.new, Stone::AST::Name)),
                      operator,
                      Stone::AST::Expression::Binary)
    end

    let(:if_state) do
      rule(Stone::AST::Statement::If).sep('if')
        .ast(rule.number(Stone::AST::Literal::Number))
        .ast(block)
    end

    let(:block) do
      rule(Stone::AST::Statement::Block)
        .sep('{')
        .string(Stone::AST::Literal::String)
        .sep('}')
    end

    let(:block2) do
      rule(Stone::AST::Statement::Block)
        .sep('{').option(rule.string(Stone::AST::Literal::String))
        .repeat(rule.sep(';', Stone::Token::EOL).option(rule.string(Stone::AST::Literal::String)))
        .sep('}')
    end

    let(:param) { rule.identifier(Set.new) }
    let(:params) { rule(Stone::AST::ParameterList).ast(param).repeat(rule.sep(',').ast(param)) }
    let(:params_list) { rule.sep('(').maybe(params).sep(')') }

    let(:defn) do
      rule(Stone::AST::Statement::Defn).sep('defn').identifier(Set.new).ast(params_list).ast(block2)
    end

    describe 'number' do
      let(:file) { 'spec/examples/primary' }
      it 'create ast of -10' do
        expect(neg_primary.parse(lexer).to_s).to eq '- 10'
      end
    end

    describe 'expression' do
      let(:file) { 'spec/examples/expression' }
      it 'create ast of (n = (4 + 1))' do
        expect(expression.parse(lexer).to_s).to eq '(n = (4 + 1))'
      end
    end

    describe 'block' do
      let(:file) { 'spec/examples/block' }
      it 'create ast of { "asdf" }' do
        expect(block.parse(lexer).to_s).to eq '(asdf)'
      end
    end

    describe 'block2' do
      let(:file) { 'spec/examples/block2' }
      it 'create ast of { "asdf" }' do
        expect(block2.parse(lexer).to_s).to eq '(asdf)'
      end
    end

    describe 'if' do
      let(:file) { 'spec/examples/if' }
      it 'create ast of (if 10 (asdf))' do
        expect(if_state.parse(lexer).to_s).to eq '(if 10 (asdf))'
      end
    end

    describe 'params_list' do
      let(:file) { 'spec/examples/params_list' }
      it 'create (a b c)' do
        expect(params_list.parse(lexer).to_s).to eq '(a b c)'
      end
    end

    describe 'defn' do
      context 'with args' do
        let(:file) { 'spec/examples/defn' }
        it 'create defn ast' do
          expect(defn.parse(lexer).to_s).to eq '(defn name (a) (asdf))'
        end
      end
    end
  end

  describe 'Helper class' do
    include Stone::Parser::Helper
    context '#rule reserved nil or 0 args' do
      it 'return Combinator class' do
        expect(rule).to be_a Stone::Parser::Combinator
      end
    end

    context '#rule received AST inherited class' do
      context 'received AST::Statemnt::binary class' do
        it 'has ASTBuilder class builder' do
          expect(rule(Stone::AST::Expression::Binary).builder).to be_a Stone::Parser::ASTBuilder
        end
      end
    end
  end
end
