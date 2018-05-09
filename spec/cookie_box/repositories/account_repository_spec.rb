# frozen_string_literal: true

RSpec.describe AccountRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_uid' do
    subject { repo.find_by_uid(uid) }

    let(:uid) { '12345' }

    context 'when account with uid exist' do
      before { Fabricate.create(:account, uid: uid) }

      it { expect(subject).to be_a Account }
    end

    context 'when account with uid inexist' do
      it { expect(subject).to be nil }
    end
  end

  describe '#owner_for_repository' do
    subject { repo.owner_for_repository(repository.id) }

    let(:account) { Fabricate.create(:account) }
    let(:repository) { Fabricate.create(:repository) }
    let(:deck) { Fabricate.create(:deck, account_id: account.id) }

    before { Fabricate.create(:deck_repo, deck_id: deck.id, repository_id: repository.id) }

    context 'when repository has a account' do
      let(:deck) { Fabricate.create(:deck, account_id: account.id) }

      it { expect(subject).to eq account }
    end

    context 'when repository has other account' do
      let(:deck) { Fabricate.create(:deck, account_id: Fabricate.create(:account).id) }

      it { expect(subject).to_not eq account }
    end
  end
end
