require 'stone/lexer/token_builder'
require 'stone/token'

describe Stone::Lexer::TokenBuilder do
  let(:token_builder) { described_class.new }
  before { token_builder.build(0) }

  context 'number token pattern' do
    let(:num_pat) { [nil, 3, nil, 3] }
    it { expect(token_builder.call(num_pat)).to be_a Stone::Token::Num }
  end

  context 'string token patter' do
    let(:str_pat) { [nil, 'str', nil, nil, 'str'] }
    it { expect(token_builder.call(str_pat)).to be_a Stone::Token::Str }
  end

  context 'id token patter' do
    let(:id_pat) { [nil, '+', nil, nil, nil] }
    it { expect(token_builder.call(id_pat)).to be_a Stone::Token::Id }
  end
end
