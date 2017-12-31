RSpec.describe Decks::Operations::Archive do
  let(:deck_repo) { double(:deck_repo, archive: true) }
  let(:operation) { described_class.new(deck: deck_repo) }

  subject { operation.call(payload) }

  let(:payload) { { deck_id: 1 } }

  it { expect(subject).to be_right }

  it 'calls archive repo method with deck id' do
    expect(deck_repo).to receive(:archive).with(1)
    subject
  end
end
