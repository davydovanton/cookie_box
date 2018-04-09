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
end
