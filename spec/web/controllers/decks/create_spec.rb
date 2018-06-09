# frozen_string_literal: true

RSpec.describe Web::Controllers::Decks::Create, type: :action do
  include Dry::Monads::Result::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { 'rack.session' => session, deck: { title: 'test title' } } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    it { expect(action.call(params)).to redirect_to('/decks') }

    it 'calls operation with current account id' do
      expect(mock_operation).to receive(:call).with(account_id: 1, title: 'test title')
      action.call(params)
    end
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
