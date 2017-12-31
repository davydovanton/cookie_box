RSpec.describe DeckRepository, type: :repository do
  let(:account_repo) { AccountRepository.new }
  let(:repo) { described_class.new }

  let(:account) { account_repo.create(name: 'anton') }

  after { account_repo.clear & repo.clear }

  describe '#all_for_account' do
    subject { repo.all_for_account(account_id) }

    before { repo.create(account_id: account.id, title: 'test') }

    context 'when account has decks' do
      let(:account_id) { account.id }

      it { expect(subject).to be_a Array }
      it { expect(subject.count).to eq 1 }
      it { expect(subject.first).to be_a Deck }
    end

    context 'when account does not have decks' do
      let(:account_id) { 0 }

      it { expect(subject).to eq [] }
    end

    context 'when account_id is nil' do
      let(:account_id) { nil }

      it { expect(subject).to eq [] }
    end
  end

  describe '#archive' do
    subject { repo.archive(deck.id) }

    let(:deck) { repo.create(account_id: account.id, title: 'test') }
    let(:updated_deck) { repo.find(deck.id) }

    it 'update deleted_at value' do
      expect(deck.deleted_at).to be nil
      subject
      expect(updated_deck.deleted_at).to be_a Time
    end
  end
end
