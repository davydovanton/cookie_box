RSpec.describe Decks::Operations::Archive do
  let(:deck_repo) { double(:deck_repo, archive: true) }
  let(:operation) { described_class.new(deck: deck_repo) }

  subject { operation.call(payload) }

  context 'when id is exist' do
    let(:payload) { { deck_id: 1 } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to receive(:archive).with(1)
      subject
    end
  end

  context 'when id is empty' do
    let(:payload) { { deck_id: nil } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end
end
