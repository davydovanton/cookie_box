RSpec.describe Repositories::Operations::Delete do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new(deck_repo: deck_repo_mock) }
  let(:deck_repo_mock) { double(:deck_repo, delete_from_deck: true) }

  subject { lib.call(deck_id: deck_id, repository_id: repository_id) }

  context 'when params valid' do
    let(:deck_id) { 1 }
    let(:repository_id) { 1 }

    it { expect(subject).to be_right }

    it 'creates a new repo <-> deck association' do
      expect(deck_repo_mock).to receive(:delete_from_deck).with(1, 1)
      subject
    end
  end

  context 'when params invalid' do
    let(:deck_id) { nil }
    let(:repository_id) { nil }

    it { expect(subject).to be_left }
    it { expect(subject.value).to eq(deck_id: ['must be filled'], repository_id: ['must be filled']) }

    it 'does not delete anything' do
      expect(deck_repo_mock).to receive(:delete_from_deck).exactly(0).times
      subject
    end
  end
end
