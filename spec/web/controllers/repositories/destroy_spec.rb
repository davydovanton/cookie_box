# frozen_string_literal: true

RSpec.describe Web::Controllers::Repositories::Destroy, type: :action do
  include Dry::Monads::Result::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params) { { 'rack.session' => session, deck_id: 1, deck_slug: '123', id: 123 } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'when operation returns success result' do
      let(:mock_operation) { Mock::SuccessListOperation.new }

      it { expect(action.call(params)).to redirect_to('/decks/123') }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(deck_id: 1, repository_id: 123)
        action.call(params)
      end
    end

    context 'when operation returns fail result' do
      let(:mock_operation) { Mock::FailListOperation.new }

      it { expect(action.call(params)).to redirect_to('/decks/123') }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(deck_id: 1, repository_id: 123)
        action.call(params)
      end
    end
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
