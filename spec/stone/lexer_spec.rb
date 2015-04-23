require 'stone/lexer'
require 'stone/line_number_reader'

describe Stone::Lexer do
  let(:file) { 'examples/sample' }
  let(:reader) { Stone::LineNumberReader.new(file) }
  let(:lexer) { described_class.new(reader) }

  describe 'do lexical analysing' do
    it '#read_token read token one by one disruptive' do
      expect(lexer.read_token.text).to eq 'while'
      expect(lexer.read_token.text).to eq 'i'
      expect(lexer.read_token.text).to eq '<'
      expect(lexer.read_token.text).to eq '10'
      expect(lexer.read_token.text).to eq '{'
      expect(lexer.read_token.text).to eq "\n"
    end

    it '#peek_token peek token one by one' do
      expect(lexer.peek_token.text).to eq 'while'
      expect(lexer.peek_token.text).to eq 'while'
      expect(lexer.read_token.text).to eq 'while'
      expect(lexer.peek_token.text).to eq 'i'
    end
  end
end
