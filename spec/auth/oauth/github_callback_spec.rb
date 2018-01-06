RSpec.describe Auth::Oauth::GithubCallback do
  include Dry::Monads::Either::Mixin

  let(:repo) { AccountRepository.new }
  let(:callback) { described_class.new({}) }
  let(:params) { { 'credentials' => {}, 'info' => {}, 'uid' => uid } }
  let(:uid) { '12345' }

  subject { callback.call(params) }

  it { expect(subject).to be_right }
  it { expect(subject.value).to be_a Account }
  it { expect(subject.value.uid).to eq uid }

  context 'when account with uid exist' do
    before { Fabricate.create(:account, uid: uid) }

    it { expect { subject }.to change { repo.all.count }.by(0) }
  end

  context 'when account with uid inexist' do
    it { expect { subject }.to change { repo.all.count }.by(1) }
  end
end
