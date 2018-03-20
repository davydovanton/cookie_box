# frozen_string_literal: true

RSpec.describe Webhooks::Controllers::Github::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  subject { action.call(params) }

  it { expect(subject).to be_success }
  it { expect(subject.last).to eq ['{}'] }
end
