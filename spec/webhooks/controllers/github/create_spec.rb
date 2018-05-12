# frozen_string_literal: true

RSpec.describe Webhooks::Controllers::Github::Create, type: :action do
  let(:operation) { ->(_) { true } }
  let(:action) { described_class.new(operation: operation) }
  let(:params) { Hash[] }

  subject { action.call(params) }

  it { expect(subject).to be_success }

  context 'when webhook contains issue key' do
    let(:params) { { issue: {} } }

    it 'calls operation with right attributes' do
      expect(operation).to receive(:call).with(webhook: { issue: {} })
      subject
    end
  end

  context 'when webhook does not contain issue key' do
    let(:params) { { zen: 'Half measures are as bad as nothing at all.' } }

    it 'calls operation with right attributes' do
      expect(operation).to_not receive(:call).with(webhook: {})
      subject
    end
  end
end
