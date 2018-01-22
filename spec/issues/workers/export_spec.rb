RSpec.describe Issues::Workers::Export do
  include Dry::Monads::Either::Mixin

  let(:operation) { -> (arg) { Right(arg) } }
  let(:worker) { described_class.new(operation: operation) }

  subject { worker.perform(1) }

  it 'calls operation' do
    expect(operation).to receive(:call).with(1).and_return(Right(1))
    subject
  end
end
