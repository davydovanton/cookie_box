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
end
