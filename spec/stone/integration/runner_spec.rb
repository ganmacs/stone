require 'stone'

describe Stone::Runner do
  let(:runner) { Stone::Runner.new(file).call }

  describe 'sample1' do
    let(:file) { 'spec/examples/integration/sample1' }
    it { expect(runner).to eq [0, 0, 10, 45] }
  end

  describe 'sample2' do
    let(:file) { 'spec/examples/integration/sample2' }
    it { expect(runner).to eq [9, 10, 10] }
  end

  describe 'sample3' do
    let(:file) { 'spec/examples/integration/sample3' }
    it { expect(runner).to eq ['fact', 36_288_00] }
  end

  describe 'sample4' do
    let(:file) { 'spec/examples/integration/sample4' }
    it { expect(runner).to eq ['counter', 1] }
  end
end
