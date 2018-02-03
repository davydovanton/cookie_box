# frozen_string_literal: true

RSpec.describe Web::Controllers::Home::Index, type: :action do
  let(:action) { described_class.new }
  let(:params)  { { 'rack.session' => session } }

  context 'when account login' do
    let(:session) { { account: Account.new(id: 1) } }

    it { expect(action.call(params)).to redirect_to('/decks') }
  end

  context 'when account not login' do
    let(:session) { {} }

    it { expect(action.call(params)).to be_success }
  end
end
