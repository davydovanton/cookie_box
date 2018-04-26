# frozen_string_literal: true

RSpec.describe Repositories::Workers::CreateWebhook do
  include Dry::Monads::Either::Mixin

  let(:operation) { ->(arg) { Right(arg) } }
  let(:logger) { double(:logger, info: nil) }
  let(:worker) { described_class.new(logger: logger, operation: operation) }

  subject { worker.perform(1) }

  it 'calls operation' do
    expect(operation).to receive(:call).with(repository_id: 1).and_return(Right(1))
    subject
  end

  context 'when operation returns success result' do
    let(:operation) { ->(arg) { Right(arg) } }

    it 'does not log something' do
      expect(logger).to_not receive(:info)
      subject
    end
  end

  context 'when operation returns failed result' do
    let(:operation) { ->(arg) { Left(arg) } }

    it 'does not log something' do
      expect(logger).to receive(:info)
      subject
    end
  end

  context 'with all dependencies' do
    let(:repo) { RepositoryRepository.new }
    let(:operation) { Repositories::Operations::CreateWebhook.new(webhook_request: ->(_) { Right(status: :ok) }) }
    let(:repository) { Fabricate.create(:repository, webhook_enable: false) }

    subject { worker.perform(repository.id) }

    after { repo.clear }

    let(:new_repository) { repo.find(repository.id) }

    it 'changes repository webhook status' do
      subject
      expect(new_repository.webhook_enable).to be true
    end
  end
end
