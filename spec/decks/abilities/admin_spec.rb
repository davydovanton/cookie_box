# frozen_string_literal: true

RSpec.describe Decks::Abilities::Admin do
  let(:account) { Account.new(roles: 'admin') }
  let(:abilities) { described_class.new }

  describe 'read ability' do
    let(:ability) { abilities.ability(:read) }

    subject { ability.call(account, nil) }

    it { expect(subject).to eq true }
  end

  describe 'create ability' do
    let(:ability) { abilities.ability(:create) }

    subject { ability.call(account, nil) }

    it { expect(subject).to eq true }
  end
end
