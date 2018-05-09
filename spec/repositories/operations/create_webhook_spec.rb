# frozen_string_literal: true

RSpec.describe Repositories::Operations::CreateWebhook do
  include Dry::Monads::Either::Mixin
  include Dry::Monads::Maybe::Mixin

  let(:account_repo) { double(:account_repo, owner_for_repository: account) }
  let(:account) { Account.new }

  let(:repository_repo) { double(:repository_repo, find: repository) }
  let(:repository) { Repository.new }

  let(:operation) do
    described_class.new(
      webhook_request: webhook_request,
      prersist_webhook_status: prersist_webhook_status,
      account_repo: account_repo,
      repository_repo: repository_repo
    )
  end

  let(:webhook_request) { ->(_) { Success(:ok) } }
  let(:prersist_webhook_status) { ->(_) { Success(:ok) } }

  subject { operation.call(payload) }

  let(:payload) { { repository_id: 1 } }

  context 'when payload valid' do
    let(:payload) { { repository_id: 1 } }

    it { expect(subject).to eq Success(:ok) }
  end

  context 'when payload invalid' do
    let(:payload) { { repository_id: 'asd' } }

    it { expect(subject).to eq Left(repository_id: ['must be an integer']) }
  end

  context 'when repo has a owner' do
    let(:account) { Account.new }

    it { expect(subject).to eq Success(:ok) }
  end

  context 'when repo has a owner' do
    let(:account) { nil }

    it { expect(subject).to eq None() }
  end

  context 'when repository exist' do
    let(:repository) { Repository.new }

    it { expect(subject).to eq Success(:ok) }
  end

  context 'when repository does not exist' do
    let(:repository) { nil }

    it { expect(subject).to eq None() }
  end

  context 'when all is okay' do
    let(:account) { Account.new(id: 5, token: '123') }
    let(:payload) { { repository_id: 1 } }

    it 'calls webhook_request with right attributes' do
      expect(webhook_request).to receive(:call).with(token: '123', repository: repository).and_return(Success(:ok))
      subject
    end

    it 'calls prersist_webhook_status with right attributes' do
      expect(prersist_webhook_status).to receive(:call).with(webhook_owner_id: 5, repository_id: 1).and_return(Success(:ok))
      subject
    end
  end
end
