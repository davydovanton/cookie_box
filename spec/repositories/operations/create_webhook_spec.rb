# frozen_string_literal: true

RSpec.describe Repositories::Operations::CreateWebhook do
  include Dry::Monads::Either::Mixin

  let(:operation) do
    described_class.new(webhook_request: webhook_request, prersist_webhook_status: prersist_webhook_status)
  end

  let(:webhook_request) { ->(_) { Right(:ok) } }
  let(:prersist_webhook_status) { ->(_) { Right(:ok) } }

  subject { operation.call(payload) }

  context 'when payload valid' do
    let(:payload) { { repository_id: 1 } }

    it { expect(subject).to eq Right(:ok) }
  end

  context 'when payload invalid' do
    let(:payload) { { repository_id: 'asd' } }

    it { expect(subject).to eq Left(repository_id: ['must be an integer']) }
  end
end
