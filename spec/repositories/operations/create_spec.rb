RSpec.describe Repositories::Operations::Create do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new(deck_repo: deck_repo_mock, get_or_create_repo: get_or_create_repo_mock) }
  let(:deck_repo_mock) { double(:deck_repo, select_or_create: DeckRepo.new) }
  let(:get_or_create_repo_mock) { double(:get_or_create_repo, call: repo_result) }
  let(:repo_result) { Right(Repository.new(id: 1)) }

  subject { lib.call(deck_id: deck_id, repo_name: repo_name) }

  context 'when params valid' do
    let(:deck_id) { 1 }
    let(:repo_name) { 'hanami/hanami' }

    context 'and repository exist' do
      let(:repo_result) { Right(Repository.new(id: 1)) }

      it { expect(subject).to be_right }

      it 'creates a new repo <-> deck association' do
        expect(deck_repo_mock).to receive(:select_or_create).with(deck_id: 1, repository_id: 1)
        subject
      end
    end

    context 'and repository does not exist' do
      let(:repo_result) { Left(:error) }

      it { expect(subject).to be_left }

      it 'creates a new repo <-> deck association' do
        expect(deck_repo_mock).to receive(:select_or_create).exactly(0).times
        subject
      end
    end
  end

  context 'when params invalid' do
    let(:deck_id) { nil }
    let(:repo_name) { nil }

    it { expect(subject).to be_left }
    it { expect(subject.value).to eq(deck_id: ['must be filled'], repo_name: ['must be filled']) }
  end
end
