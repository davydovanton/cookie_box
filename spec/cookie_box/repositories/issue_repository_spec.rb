# frozen_string_literal: true

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

  describe '#find_by_vcs_source' do
    let(:issue) { Fabricate.create(:issue, vcs_source_id: vcs_source_id) }
    let(:vcs_source_id) { 123 }

    subject { repo.find_by_vcs_source(vcs_source_id) }

    context 'when db contain the issue with vcs source' do
      before { issue }

      it { expect(subject).to eq issue }
    end

    context 'when db does not contain the issue with vcs source' do
      it { expect(subject).to eq nil }
    end
  end
end
