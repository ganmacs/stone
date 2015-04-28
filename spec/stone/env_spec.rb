require 'stone/env'

describe Stone::Env do
  describe '#[]= and []' do
    context 'have not outer env' do
      let(:env) { Stone::Env.new }
      before do
        env['test'] = 123
        env.update('hoge', 234)
      end
      it { expect(env['test']).to eq 123 }
      it { expect(env.get('hoge')).to eq 234 }
    end

    context 'have outer env' do
      let(:outer) { Stone::Env.new }
      let(:env) { Stone::Env.new(outer) }
      before do
        outer['outer'] = 'inner'
        env['outer'] = 'outer'
      end

      it { expect(env['outer']).to eq 'outer' }
      it 'changes outer variable' do
        expect(outer['outer']).to eq 'outer'
      end
    end
  end
end
