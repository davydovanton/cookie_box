# frozen_string_literal: true

RSpec.describe Repositories::Libs::PrersistWebhookStatus do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new }

  subject { lib.call({}) }

  it { expect(subject).to eq Right(:ok) }
end
