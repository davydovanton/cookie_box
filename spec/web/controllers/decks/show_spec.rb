# frozen_string_literal: true

RSpec.describe Web::Controllers::Decks::Show, type: :action do
  include Dry::Monads::Result::Mixin

  let(:mock_operation) { Mock::SuccessListOperation.new }
  let(:action) { described_class.new(operation: mock_operation) }
  let(:params)  { { 'rack.session' => session, id: 1 } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:deck) { Deck.new(id: 1, account_id: 1) }

      before { allow(mock_operation).to receive(:call).and_return(Success(deck: deck, issues: {})) }

      it { expect(action.call(params)).to be_success }

      it 'calls operation with current account id' do
        expect(mock_operation).to receive(:call).with(1).and_return(Success(deck: deck, issues: {}))
        action.call(params)
      end

      it 'sets decs variable' do
        action.call(params)
        expect(action.deck).to eq deck
      end
    end

    context 'and operation returns not account deck' do
      before { allow(mock_operation).to receive(:call).and_return(Success(deck: deck, issues: {})) }

      let(:deck) { Deck.new(id: 1, account_id: 2) }

      it { expect(action.call(params)).to have_http_status(404) }
      it { expect(action.call(params)).to match_in_body('Not found') }

      it 'calls operation with current account id' do
        action.call(params)
      end
    end

    context 'and operation returns public not account deck' do
      before { allow(mock_operation).to receive(:call).and_return(Success(deck: deck, issues: {})) }

      let(:deck) { Deck.new(id: 1, account_id: 2, published: true) }

      it { expect(action.call(params)).to be_success }

      it 'sets decs variable' do
        action.call(params)
        expect(action.deck).to eq deck
      end
    end

    context 'and operation returns fail result' do
      let(:mock_operation) { Mock::FailListOperation.new }

      it { expect(action.call(params)).to have_http_status(404) }
      it { expect(action.call(params)).to match_in_body('Not found') }
    end
  end

  context 'when account not login' do
    before { allow(mock_operation).to receive(:call).and_return(Success(deck: deck, issues: {})) }

    let(:deck) { Deck.new(id: 1, account_id: 1) }

    let(:session) { {} }

    it { expect(action.call(params)).to have_http_status(404) }
    it { expect(action.call(params)).to match_in_body('Not found') }
  end

  context 'when account not login but deck is public' do
    before { allow(mock_operation).to receive(:call).and_return(Success(deck: deck, issues: {})) }

    let(:deck) { Deck.new(id: 1, account_id: 1, published: true) }

    let(:session) { {} }

    it { expect(action.call(params)).to be_success }

    it 'sets decs variable' do
      action.call(params)
      expect(action.deck).to eq deck
    end
  end
end
