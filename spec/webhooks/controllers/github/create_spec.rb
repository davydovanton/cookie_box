# frozen_string_literal: true

RSpec.describe Webhooks::Controllers::Github::Create, type: :action do
  let(:operation) { ->(_) { true } }
  let(:action) { described_class.new(operation: operation) }
  let(:params) { Hash[] }

  subject { action.call(params) }

  it { expect(subject).to be_success }

  it 'calls operation with right attributes' do
    expect(operation).to receive(:call).with(webhook: {})
    subject
  end
end
