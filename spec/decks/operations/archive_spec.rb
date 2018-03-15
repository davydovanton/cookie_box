# frozen_string_literal: true

RSpec.describe Decks::Operations::Archive do
  let(:deck_repo) { double(:deck_repo, archive: true, find_by_slug: deck) }
  let(:operation) { described_class.new(repository: deck_repo) }
  let(:deck) { Deck.new(id: 1, account_id: account_id) }
  let(:account_id) { 1 }

  subject { operation.call(payload) }

  context 'when id is exist but account nil' do
    let(:payload) { { deck_slug: '123', account_id: nil } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end

  context 'when id and account id are exist' do
    let(:payload) { { deck_slug: '123', account_id: account_id } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to receive(:archive).with(1)
      subject
    end
  end

  context 'when id is exist bud deck owned by other account' do
    let(:payload) { { deck_slug: '123', account_id: 2 } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end

  context 'when id is empty' do
    let(:deck_repo) { double(:deck_repo, archive: true, find_by_slug: nil) }
    let(:payload) { { deck_slug: nil, account_id: account_id } }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end
end
