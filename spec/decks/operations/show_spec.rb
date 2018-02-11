# frozen_string_literal: true

RSpec.describe Decks::Operations::Show do
  let(:operation) { described_class.new(deck: deck_repo) }
  let(:slug) { '1234567' }

  subject { operation.call(slug) }

  context 'when deck exist' do
    let(:deck_repo) { double(:deck_repo, find_by_slug_with_repos: Deck.new(slug: '1234567')) }

    it { expect(subject).to be_right }
<<<<<<< 14f16aac0ba448eee0f793f10cc7577cb1ab8eba
    it { expect(subject.value.slug).to eq slug }
=======
    it { expect(subject.value!).to eq Deck.new(id: 1) }
>>>>>>> Use latest dry-monads version
  end

  context 'when deck unexist' do
    let(:deck_repo) { double(:deck_repo, find_by_slug_with_repos: nil) }

    it { expect(subject).to be_left }
    it { expect(subject.failure).to eq :not_found }
  end
end
