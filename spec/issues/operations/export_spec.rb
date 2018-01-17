RSpec.describe Issues::Operations::Export do
  include Dry::Monads::Either::Mixin

  # include Import['repositories.repository', 'repositories.issue', 'issues.libs.github_list']

  let(:operation) { described_class.new }

  subject { operation.call(1) }

  xit { expect(subject).to eq Right(:ok) }
end
