RSpec.describe Web::Views::Home::Index, type: :view do
  let(:account) { Account.new }
  let(:exposures) { { current_account: account } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#auth_button' do
    subject { view.auth_button.to_s }

    context 'when current_account is empty' do
      let(:account) { Account.new }

      it { expect(subject).to eq '<a href="/auth/github">Login</a>' }
    end

    context 'when current_account is not empty' do
      let(:account) { Account.new(login: 'anton') }

      it { expect(subject).to eq '<a href="/auth/logout">Logout</a>' }
    end
  end

  it 'exposes #current_account' do
    expect(view.current_account).to be_a Account
  end
end
