RSpec.describe DeckRepoRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#delete_from_deck' do
    it 'deletes deck repo by id' do
      deck_repo = Fabricate.create(:deck_repo)

      expect do
        repo.delete_from_deck(deck_repo.deck_id, deck_repo.repository_id)
      end.to change { repo.all.count }.by(-1)
    end
  end

  describe '#select_or_create' do
    subject { repo.select_or_create(deck_id: deck_id, repository_id: repository_id) }

    let(:deck_id) { Fabricate.create(:deck).id }
    let(:repository_id) { Fabricate.create(:repository).id }

    context 'when dec repo with dec and repo exist' do
      it { expect(subject).to be_a DeckRepo }
      it { expect{ subject }.to change { repo.all.count }.by(1) }
    end

    context 'when dec repo with dec and repo does not exist' do
      before { repo.create(deck_id: deck_id, repository_id: repository_id) }

      it { expect(subject).to be_a DeckRepo }
      it { expect{ subject }.to change { repo.all.count }.by(0) }
    end
  end
end
