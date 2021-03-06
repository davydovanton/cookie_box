# frozen_string_literal: true

RSpec.describe Issues::Operations::Export do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(repository: repository_repo, issue: issue_repo, github_list: github_list) }

  let(:repository_repo) { double(:repository_repo, find: repository_entity) }
  let(:repository_entity) { Repository.new }

  let(:issue_repo) { double(:issue_repo, create: nil) }
  let(:github_list) { double(:github_list) }

  subject { operation.call(1) }

  context 'when repository does not exist' do
    let(:repository_entity) { nil }

    it { expect(subject).to eq Failure(:not_found) }
  end

  context 'when github responses error' do
    let(:repository_entity) { Repository.new }
    let(:github_list) { double(:github_list, call: Failure(:github_error)) }

    it { expect(subject).to eq Failure(:github_error) }
  end

  context 'when repository exist and issues too' do
    let(:repository_entity) { Repository.new }
    let(:github_list) { double(:github_list, call: Success([{ title: 'title' }])) }

    it 'saves issues and returns right result' do
      expect(issue_repo).to receive(:create).with(repository_id: 1, title: 'title')
      expect(subject).to be_right
    end
  end
end
