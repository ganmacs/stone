require 'stone'

describe Stone::Runner do
  let(:runner) { Stone::Runner.new(file).call }

  describe 'basic' do
    let(:file) { 'spec/examples/integration/sample1' }
    it { expect(runner).to eq [0, 0, 10, 45] }
  end

  describe 'while' do
    let(:file) { 'spec/examples/integration/sample2' }
    it { expect(runner).to eq [9, 10, 10] }
  end

  describe 'function + while' do
    let(:file) { 'spec/examples/integration/sample3' }
    it { expect(runner).to eq ['fact', 36_288_00] }
  end

  describe 'function with nil arg' do
    let(:file) { 'spec/examples/integration/sample4' }
    it { expect(runner).to eq ['counter', 1] }
  end

  describe 'closure' do
    let(:file) { 'spec/examples/integration/sample5' }
    let(:result) do
      r = runner
      [r[0], *r.drop(2)] # result[1] is closure object
    end
    it { expect(result).to eq ['counter', 2, 3] }
  end
end
