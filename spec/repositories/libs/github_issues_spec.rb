# frozen_string_literal: true

RSpec.describe Repositories::Libs::GithubIssue do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new }
end
