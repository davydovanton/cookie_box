RSpec.describe Web::Controllers::Decks::Index, type: :action do
  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { account_id: 1, 'rack.session' => session } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:mock_operation) { Mock::SuccessListOperation.new }

      it { expect(action.call(params)).to be_success }

      it 'sets decs variable' do
        action.call(params)
        expect(action.decks).to eq []
      end
    end

    context 'and operation returns fail result' do
      let(:mock_operation) { Mock::FailListOperation.new }

      it { expect(action.call(params)).to be_success }

      it 'sets decs variable' do
        action.call(params)
        expect(action.decks).to eq nil
      end
    end
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
