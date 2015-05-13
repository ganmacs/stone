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

  describe 'class' do
    let(:file) { 'spec/examples/integration/sample6' }
    let(:result) do
      r = runner
      [r[0], *r.drop(2)] # result[1] is closure object
    end
    it { expect(result).to eq ['Position', 4, 10, 10, 4] }
  end

  describe 'ary' do
    let(:file) { 'spec/examples/integration/sample7' }
    it { expect(runner).to eq [[2, 3, 4], 3, 'three', 'three', 'three one'] }
  end

  # describe 'native add fun' do
  #   let(:file) { 'spec/examples/integration/sample8' }
  #   it { expect(runner).to eq [2, 1, 3] }
  # end

  # describe 'native add let' do
  #   let(:file) { 'spec/examples/integration/sample9' }
  #   it { expect(runner).to eq [nil, 1] }
  # end

  describe 'native add let' do
    let(:file) { 'spec/examples/integration/sample11' }
    it { expect(runner).to eq [nil, 4] }
  end
end
