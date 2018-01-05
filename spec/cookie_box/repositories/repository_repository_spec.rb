RSpec.describe RepositoryRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_name' do
    before { Fabricate.create(:repository, full_name: 'hanami/hanami') }

    it { expect(repo.find_by_name('hanami/events')).to be_nil }
    it { expect(repo.find_by_name('hanami/hanami')).to_not be_nil }
  end
end
