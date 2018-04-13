# frozen_string_literal: true

RSpec.describe Decks::Operations::Show do
  include Dry::Monads::Either::Mixin

  let(:operation) { described_class.new(deck_repo: deck_repo, domain_caller: domain_caller) }
  let(:domain_caller) { double(:events, call: Success({})) }
  let(:slug) { '1234567' }

  subject { operation.call(slug) }

  context 'when deck exist' do
    let(:deck_repo) { double(:deck_repo, find_by_slug_with_repos: Deck.new(slug: '1234567')) }

    it { expect(subject).to be_right }
    it { expect(subject.value![:deck].slug).to eq slug }
    it { expect(subject.value![:deck]).to eq Deck.new(slug: '1234567') }
    it { expect(subject.value![:issues]).to eq({}) }
  end

  context 'when deck unexist' do
    let(:deck_repo) { double(:deck_repo, find_by_slug_with_repos: nil) }

    it { expect(subject).to be_left }
    it { expect(subject.failure).to eq :not_found }
  end
end
