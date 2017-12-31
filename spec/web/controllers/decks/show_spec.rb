RSpec.describe Web::Controllers::Decks::Show, type: :action do
  include Dry::Monads::Either::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { 'rack.session' => session, id: 1 } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:mock_operation) { Mock::SuccessListOperation.new }

      it { expect(action.call(params)).to be_success }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(1).and_return(Right([]))
        action.call(params)
      end

      it 'sets decs variable' do
        action.call(params)
        expect(action.deck).to eq []
      end
    end

    context 'and operation returns fail result' do
      let(:mock_operation) { Mock::FailListOperation.new }

      it { expect(action.call(params)).to have_http_status(404) }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(1).and_return(Right([]))
        action.call(params)
      end

      it 'does not set decs variable' do
        action.call(params)
        expect(action.deck).to eq nil
      end
    end
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
