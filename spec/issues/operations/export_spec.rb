RSpec.describe Issues::Operations::Export do
  include Dry::Monads::Either::Mixin

  let(:operation) { described_class.new }

  subject { operation.call(1) }

  it { expect(subject).to eq Right(:ok) }
end
