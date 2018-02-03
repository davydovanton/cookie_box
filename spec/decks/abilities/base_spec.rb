# frozen_string_literal: true

RSpec.describe Decks::Abilities::Base do
  let(:abilities) { Decks::Abilities::Base.new }
  let(:deck) { Deck.new }
  let(:account) { Account.new }

  describe 'edit ability' do
    let(:ability) { abilities.ability(:read) }

    subject { ability.call(account, deck) }

    context 'when deck is publish' do
      let(:deck) { Deck.new(publish: true) }

      it { expect(subject).to eq true }
    end

    context 'when deck publish is nil' do
      context 'and account is owner of deck' do
        let(:deck) { Deck.new(publish: false, account_id: 1) }
        let(:account) { Account.new(id: 1) }

        it { expect(subject).to eq true }
      end

      context 'and account is not owner of deck' do
        let(:deck) { Deck.new(publish: false, account_id: 2) }
        let(:account) { Account.new(id: 1) }

        it { expect(subject).to eq false }
      end
    end

    context 'when deck is nil' do
      let(:deck) { nil }

      it { expect(subject).to eq nil }
    end
  end
end
