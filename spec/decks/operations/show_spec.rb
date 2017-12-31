RSpec.describe Decks::Operations::Show do
  let(:operation) { described_class.new(deck: deck_repo) }
  let(:id) { 1 }

  subject { operation.call(id) }

  context 'when deck exist' do
    let(:deck_repo) { double(:deck_repo, find: Deck.new(id: 1)) }

    it { expect(subject).to be_right }
    it { expect(subject.value).to eq Deck.new(id: 1) }
  end

  context 'when deck unexist' do
    let(:deck_repo) { double(:deck_repo, find: nil) }

    it { expect(subject).to be_left }
    it { expect(subject.value).to eq :not_found }
  end
end
