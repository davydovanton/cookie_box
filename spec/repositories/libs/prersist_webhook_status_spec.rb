# frozen_string_literal: true

RSpec.describe Repositories::Libs::PrersistWebhookStatus do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new(repository: repo) }

  subject { lib.call(payload) }

  context 'when mock repository' do
    let(:repo) { double(:repo, update: Repository.new) }
    let(:payload) { { repository_id: 1, webhook_owner_id: 5 } }

    it 'calls update method with webhook flag' do
      expect(repo).to receive(:update).with(1, webhook_enable: true, webhook_owner_id: 5)
      subject
    end
  end
end
