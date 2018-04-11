# frozen_string_literal: true

RSpec.describe Issues::Operations::Update do
  include Dry::Monads::Either::Mixin

  let(:operation) { described_class.new }

  subject { operation.call({}) }
end
