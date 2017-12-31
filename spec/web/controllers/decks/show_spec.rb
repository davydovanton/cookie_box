RSpec.describe Web::Controllers::Decks::Show, type: :action do
  include Dry::Monads::Either::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { 'rack.session' => session, id: 1 } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      before { allow(mock_operation).to receive(:call).and_return(Right(deck)) }
      let(:deck) { Deck.new(account_id: 1) }

      it { expect(action.call(params)).to be_success }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(1).and_return(Right(deck))
        action.call(params)
      end

      it 'sets decs variable' do
        action.call(params)
        expect(action.deck).to eq deck
      end
    end

    context 'and operation returns not account deck' do
      before { allow(mock_operation).to receive(:call).and_return(Right(deck)) }
      let(:deck) { Deck.new(account_id: 2) }

      it { expect(action.call(params)).to have_http_status(404) }

      it 'calls operation with current account id' do
        action.call(params)
      end
    end

    context 'and operation returns fail result' do
      let(:mock_operation) { Mock::FailListOperation.new }

      it { expect(action.call(params)).to have_http_status(404) }
    end
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
