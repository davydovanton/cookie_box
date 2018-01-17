RSpec.describe Issues::Workers::Export do
  include Dry::Monads::Either::Mixin

  let(:operation) { -> (arg) { arg } }
  let(:worker) { described_class.new(operation: operation) }

  subject { worker.perform(1) }

  it { expect(subject).to eq 1 }
end
