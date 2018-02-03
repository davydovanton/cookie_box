# frozen_string_literal: true

RSpec.describe Web::Controllers::PublishedDecks::Create, type: :action do
  include Dry::Monads::Either::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { 'rack.session' => session, deck: { id: 1 } } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    it { expect(action.call(params)).to redirect_to('/decks') }

    it 'calls operation with current account id' do
      expect(mock_operation).to receive(:call).with(1)
      action.call(params)
    end
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
