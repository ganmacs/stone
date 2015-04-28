require 'stone/evaluator'
require 'stone/token'

describe Stone do
  let(:env) { {} }

  describe 'name' do
    let(:token) { Stone::Token::Id.new(0, 'var') } # use mock
    let(:name_ast) { Stone::AST::Name.new(token) }
    before { env['var'] = 10 }

    it 'eval ast value' do
      expect(name_ast.eval(env)).to eq 10
    end
  end

  describe 'Number' do
    let(:token) { Stone::Token::Num.new(0, 10) } # use mock
    let(:number_ast) { Stone::AST::Literal::Number.new(token) }

    it 'eval ast value' do
      expect(number_ast.eval(env)).to eq 10
    end
  end

  describe 'string' do
    let(:token) { Stone::Token::Str.new(0, 'test') } # use mock
    let(:string_ast) { Stone::AST::Literal::String.new(token) }

    it 'eval ast value' do
      expect(string_ast.eval(env)).to eq 'test'
    end
  end

  describe 'Binary' do
    let(:id) { Stone::Token::Id.new(0, 'n') }
    let(:num) { Stone::Token::Num.new(0, 1) }
    let(:ast_id) { Stone::AST::Name.new(id) }
    let(:ast_num) { Stone::AST::Literal::Number.new(num) }

    context 'set variable' do
      let(:op) { Stone::Token::Id.new(0, '=') }
      let(:ast_op) { Stone::AST::Name.new(op) }
      let(:binary_ast) { Stone::AST::Expression::Binary.new([ast_id, ast_op, ast_num]) }
      before do
        env['n'] = 10
        binary_ast.eval(env)
      end
      it { expect(env['n']).to eq 1 }
    end

    context 'eval compute number' do
      let(:op) { Stone::Token::Id.new(0, '+') }
      let(:ast_op) { Stone::AST::Name.new(op) }
      let(:binary_ast) { Stone::AST::Expression::Binary.new([ast_id, ast_op, ast_num]) }
      before { env['n'] = 10 }
      it { expect(binary_ast.eval(env)).to eq 11 }
    end

    context 'eval greater or smaller number' do
      let(:op) { Stone::Token::Id.new(0, '<') }
      let(:ast_op) { Stone::AST::Name.new(op) }
      let(:binary_ast) { Stone::AST::Expression::Binary.new([ast_id, ast_op, ast_num]) }
      before { env['n'] = 10 }
      it { expect(binary_ast.eval(env)).to eq Stone::FALSE }
    end

    context 'eval equal number' do
      let(:op) { Stone::Token::Id.new(0, '==') }
      let(:ast_op) { Stone::AST::Name.new(op) }
      let(:binary_ast) { Stone::AST::Expression::Binary.new([ast_id, ast_op, ast_num]) }
      before { env['n'] = 10 }
      it { expect(binary_ast.eval(env)).to eq Stone::FALSE }
    end

    context 'concat string' do
      let(:id) { Stone::Token::Id.new(0, 'n') }
      let(:str) { Stone::Token::Str.new(0, '_hoge') }
      let(:ast_id) { Stone::AST::Name.new(id) }
      let(:ast_str) { Stone::AST::Literal::String.new(str) }

      let(:op) { Stone::Token::Id.new(0, '+') }
      let(:ast_op) { Stone::AST::Name.new(op) }
      let(:binary_ast) { Stone::AST::Expression::Binary.new([ast_id, ast_op, ast_str]) }
      before { env['n'] = 'test' }

      it { expect(binary_ast.eval(env)).to eq 'test_hoge' }
    end
  end
end
