# frozen_string_literal: true

RSpec.describe Web::Controllers::Decks::Index, type: :action do
  include Dry::Monads::Result::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { 'rack.session' => session } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:mock_operation) { Mock::SuccessListOperation.new }

      it { expect(action.call(params)).to be_success }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(1).and_return(Success([]))
        action.call(params)
      end

      it 'sets decs variable' do
        action.call(params)
        expect(action.decks).to eq []
      end
    end

    context 'and operation returns fail result' do
      let(:mock_operation) { Mock::FailListOperation.new }

      it { expect(action.call(params)).to be_success }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(1).and_return(Success([]))
        action.call(params)
      end

      it 'does not set decs variable' do
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
