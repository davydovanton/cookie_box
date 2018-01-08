RSpec.describe IssueRepository, type: :repository do
  let(:repo) { IssueRepository.new }

  describe '#all_for_deck' do
    let(:deck) { Fabricate.create(:deck) }
    let(:deck_repo) { Fabricate.create(:deck_repo, deck_id: deck.id) }

    before { Fabricate.create(:issue, repository_id: deck_repo.repository_id) }

    context 'when deck contain any issues' do
      it { expect(repo.all_for_deck(deck.id)).to be_any }
    end

    context 'when deck does not contain any issues' do
      let(:other_deck) { Fabricate.create(:deck) }

      it { expect(repo.all_for_deck(other_deck.id)).to be_empty }
    end

    context 'when deck id invalid' do
      it { expect(repo.all_for_deck(0)).to be_empty }
    end
  end
end
