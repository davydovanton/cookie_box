# frozen_string_literal: true

RSpec.describe Decks::Abilities::Base do
  let(:account) { Account.new(roles: 'regular') }
  let(:abilities) { Decks::Abilities::Base.new }

  describe 'read ability' do
    let(:deck) { Deck.new }
    let(:account) { Account.new(roles: 'regular') }
    let(:ability) { abilities.ability(:read) }

    subject { ability.call(account, deck) }

    context 'when deck is publish' do
      let(:deck) { Deck.new(publish: true) }

      it { expect(subject).to eq true }
    end

    context 'when deck publish is nil' do
      context 'and account is owner of deck' do
        let(:deck) { Deck.new(publish: false, account_id: 1) }
        let(:account) { Account.new(id: 1, roles: 'regular') }

        it { expect(subject).to eq true }
      end

      context 'and account is not owner of deck' do
        let(:deck) { Deck.new(publish: false, account_id: 2) }
        let(:account) { Account.new(id: 1, roles: 'regular') }

        it { expect(subject).to eq false }
      end
    end

    context 'when deck is nil' do
      let(:deck) { nil }

      it { expect(subject).to eq nil }
    end
  end

  describe 'create ability' do
    let(:deck_count) { 0 }
    let(:ability) { abilities.ability(:create) }

    subject { ability.call(account, deck_count) }

    context 'when account has less than 0 decks' do
      let(:deck_count) { -1 }

      it { expect(subject).to eq false }
    end

    context 'when account has 0 decks' do
      let(:deck_count) { 0 }

      it { expect(subject).to eq true }
    end

    context 'when account has less than 3 decks' do
      let(:deck_count) { 2 }

      it { expect(subject).to eq true }
    end

    context 'when account has 3 decks' do
      let(:deck_count) { 3 }

      it { expect(subject).to eq true }
    end

    context 'when account has more than 3 decks' do
      let(:deck_count) { 4 }

      it { expect(subject).to eq false }
    end
  end
end
