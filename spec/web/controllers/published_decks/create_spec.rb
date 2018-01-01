RSpec.describe Web::Controllers::PublishedDecks::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to redirect_to('/') }
end
