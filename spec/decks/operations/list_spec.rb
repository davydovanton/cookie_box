RSpec.describe Decks::Operations::List do
  let(:operation) { described_class.new }
  let(:account_id) { 1 }

  subject { operation.call(account_id) }

  it { expect(subject).to be_right }
end
