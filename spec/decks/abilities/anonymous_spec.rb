# frozen_string_literal: true

RSpec.describe Decks::Abilities::Anonymous do
  let(:account) { Account.new }
  let(:abilities) { described_class.new }

  describe 'read ability' do
    let(:deck) { Deck.new }
    let(:ability) { abilities.ability(:read) }

    subject { ability.call(account, deck) }

    context 'when deck is null' do
      let(:deck) { nil }

      it { expect(subject).to eq false }
    end

    context 'when deck is not published' do
      let(:deck) { Deck.new }

      it { expect(subject).to eq false }
    end

    context 'when deck is published' do
      let(:deck) { Deck.new(published: true) }

      it { expect(subject).to eq true }
    end
  end

  describe 'create ability' do
    let(:ability) { abilities.ability(:create) }

    subject { ability.call(account, nil) }

    it { expect(subject).to eq false }
  end
end
