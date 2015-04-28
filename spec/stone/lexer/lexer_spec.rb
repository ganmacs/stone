require 'stone/lexer/lexer'
require 'stone/lexer/line_number_reader'

describe Stone::Lexer do
  let(:file) { 'spec/examples/while' }
  let(:reader) { Stone::LineNumberReader.new(file) }
  let(:lexer) { described_class.new(reader) }

  describe 'do lexical analysing' do
    it '#read_token read token one by one disruptive' do
      expect(lexer.read_token.text).to eq 'i'
      expect(lexer.read_token.text).to eq '='
      expect(lexer.read_token.text).to eq '0'
      expect(lexer.read_token.text).to eq "\n"
      expect(lexer.read_token.text).to eq 'sum'
      expect(lexer.read_token.text).to eq '='
      expect(lexer.read_token.text).to eq '0'
      expect(lexer.read_token.text).to eq "\n"
      expect(lexer.read_token.text).to eq 'while'
      expect(lexer.read_token.text).to eq 'i'
      expect(lexer.read_token.text).to eq '<'
    end

    it '#peek_token peek token one by one' do
      expect(lexer.peek_token.text).to eq 'i'
      expect(lexer.peek_token.text).to eq 'i'
      expect(lexer.read_token.text).to eq 'i'
      expect(lexer.peek_token.text).to eq '='
    end
  end
end
