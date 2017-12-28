RSpec.describe Decks::Operations::Create do
  let(:deck_repo) { double(:deck_repo, create: Deck.new) }
  let(:operation) { described_class.new(deck: deck_repo) }

  subject { operation.call(payload) }

  context 'when context is valid' do
    let(:payload) { { title: 'test', account_id: 1 } }

    it { expect(subject).to be_right }
    it { expect(subject.value).to be_a Deck }
  end

  context 'when context is invalid' do
    let(:payload) { {} }

    it { expect(subject).to be_left }
    it do
      expect(subject.value).to eq [:invalid_data, {
        title: ['is missing'],
        account_id: ['is missing']
      }]
    end
  end
end
