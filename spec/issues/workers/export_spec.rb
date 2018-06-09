# frozen_string_literal: true

RSpec.describe Issues::Workers::Export do
  include Dry::Monads::Result::Mixin

  let(:operation) { ->(arg) { Success(arg) } }
  let(:logger) { double(:logger, info: nil) }
  let(:worker) { described_class.new(logger: logger, operation: operation) }

  subject { worker.perform(1) }

  it 'calls operation' do
    expect(operation).to receive(:call).with(1).and_return(Success(1))
    subject
  end

  context 'when operation returns success result' do
    let(:operation) { ->(arg) { Success(arg) } }

    it 'does not log something' do
      expect(logger).to_not receive(:info)
      subject
    end
  end

  context 'when operation returns failed result' do
    let(:operation) { ->(arg) { Failure(arg) } }

    it 'does not log something' do
      expect(logger).to receive(:info)
      subject
    end
  end
end
