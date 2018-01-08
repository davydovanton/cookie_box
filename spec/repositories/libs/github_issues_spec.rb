RSpec.describe Repositories::Libs::GithubIssues do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new }
end
