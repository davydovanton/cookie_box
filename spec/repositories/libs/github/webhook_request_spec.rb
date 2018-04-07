# frozen_string_literal: true

RSpec.describe Repositories::Libs::Github::WebhookRequest do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new }

  subject { lib.call({}) }

  it { expect(subject).to eq Right(:ok) }
end
