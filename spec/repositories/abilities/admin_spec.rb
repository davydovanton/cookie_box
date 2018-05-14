# frozen_string_literal: true

RSpec.describe Repositories::Abilities::Admin do
  let(:account) { Account.new(roles: 'admin') }
  let(:abilities) { described_class.new }

  describe 'create ability' do
    let(:ability) { abilities.ability(:create) }

    subject { ability.call(account, nil) }

    it { expect(subject).to eq true }

    context 'when account has other role' do
      let(:account) { Account.new(roles: 'admin') }
      subject { described_class.valid_role?(account, nil) }

      it { expect(subject).to eq true }
    end

    context 'when account has regular role' do
      let(:account) { Account.new(roles: 'regular') }
      subject { described_class.valid_role?(account, nil) }

      it { expect(subject).to eq false }
    end
  end
end
