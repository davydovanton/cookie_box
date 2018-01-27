RSpec.describe Decks::Operations::Archive do
  let(:deck_repo) { double(:deck_repo, archive: true, find: deck) }
  let(:operation) { described_class.new(deck: deck_repo) }
  let(:deck) { Deck.new(account_id: account_id) }
  let(:account_id) { 1 }

  subject { operation.call(payload) }

  context 'when id is exist but account nil' do
    let(:payload) { { deck_id: 1, account_id: nil } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end

  context 'when id and account id are exist' do
    let(:payload) { { deck_id: 1, account_id: account_id } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to receive(:archive).with(1)
      subject
    end
  end

  context 'when id is exist bud deck owned by other account' do
    let(:payload) { { deck_id: 1, account_id: 2 } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end

  context 'when id is empty' do
    let(:deck_repo) { double(:deck_repo, archive: true, find: nil) }
    let(:payload) { { deck_id: nil, account_id: account_id } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end
end
