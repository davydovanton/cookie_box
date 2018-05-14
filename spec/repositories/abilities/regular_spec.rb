# frozen_string_literal: true

RSpec.describe Repositories::Abilities::Regular do
  let(:account) { Account.new(roles: 'regular') }
  let(:abilities) { described_class.new }

  describe 'create ability' do
    let(:repositories_count) { 0 }
    let(:ability) { abilities.ability(:create) }

    subject { ability.call(account, repositories_count) }

    context 'when deck has less than 0 repositories' do
      let(:repositories_count) { -1 }

      it { expect(subject).to eq false }
    end

    context 'when deck has 0 repositories' do
      let(:repositories_count) { 0 }

      it { expect(subject).to eq true }
    end

    context 'when deck has less than 7 repositories' do
      let(:repositories_count) { 2 }

      it { expect(subject).to eq true }
    end

    context 'when deck has 7 repositories' do
      let(:repositories_count) { 7 }

      it { expect(subject).to eq true }
    end

    context 'when deck has more than 7 repositories' do
      let(:repositories_count) { 8 }

      it { expect(subject).to eq false }
    end

    context 'when account has other role' do
      let(:account) { Account.new(roles: 'admin') }
      subject { described_class.valid_role?(account, nil) }

      it { expect(subject).to eq false }
    end

    context 'when account has regular role' do
      let(:account) { Account.new(roles: 'regular') }
      subject { described_class.valid_role?(account, nil) }

      it { expect(subject).to eq true }
    end
  end
end
