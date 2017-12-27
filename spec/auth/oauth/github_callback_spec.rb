RSpec.describe GithubCallback do
  include Dry::Monads::Either::Mixin

  let(:callback) { described_class.new({}) }
  let(:params) { { 'info' => {} } }

  subject { callback.call(params) }

  it { expect(subject).to be_right }
  it { expect(subject.value).to eq(login: nil, email: nil, name: nil, image_url: nil) }
end
