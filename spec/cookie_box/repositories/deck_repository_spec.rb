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
      it { expect(subject.first.title).to eq 'test' }
    end

    context 'when account has archived deck' do
      before { repo.create(account_id: account.id, title: 'archived deck', deleted_at: Time.now) }

      let(:account_id) { account.id }

      it { expect(subject).to be_a Array }
      it { expect(subject.count).to eq 1 }
      it { expect(subject.first).to be_a Deck }
      it { expect(subject.first.title).to eq 'test' }
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

  describe '#publish' do
    subject { repo.publish(deck.id) }

    let(:deck) { repo.create(account_id: account.id, title: 'title', published: false) }
    let(:updated_deck) { repo.find(deck.id) }

    it 'update deleted_at value' do
      expect(deck.published).to be false
      subject
      expect(updated_deck.published).to be true
    end
  end

  describe '#find_with_repos' do
    let(:repository_repo) { RepositoryRepository.new }
    let(:deck_repo_repo) { DeckRepoRepository.new }
    let(:deck) { repo.create(account_id: account.id, title: 'title') }

    subject { repo.find_with_repos(deck.id) }

    after { deck_repo_repo.clear & repository_repo.clear & account_repo.clear & repo.clear }

    context 'when deck has repos' do
      before do
        repository = repository_repo.create(full_name: 'hanami/hanami')
        deck_repo_repo.create(repository_id: repository.id, deck_id: deck.id)
      end

      it { expect(subject.repositories).not_to be_empty }
      it { expect(subject.repositories.first).to be_a Repository }
    end

    context 'when deck has not repos' do
      it { expect(subject.repositories).to eq [] }
    end
  end
end
