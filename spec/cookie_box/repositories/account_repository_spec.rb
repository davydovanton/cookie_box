RSpec.describe AccountRepository, type: :repository do
  let(:repo) { described_class.new }

  after { repo.clear }

  describe '#find_by_uid' do
    subject { repo.find_by_uid(uid) }

    let(:uid) { '12345' }

    context 'when account with uid exist' do
      before { Fabricate.create(:account, uid: uid) }

      it { expect(subject).to be_a Account }
    end

    context 'when account with uid inexist' do
      it { expect(subject).to be nil }
    end
  end
end
