RSpec.describe Web::Views::Decks::Show, type: :view do
  let(:exposures) { { issues: [], params: {}, deck: deck, current_account: current_account } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/decks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:deck)      { Deck.new(title: 'test deck', repositories: [Repository.new]) }
  let(:current_account) { Account.new }

  context 'when owner open the deck' do
    let(:deck) { Deck.new(account_id: 1, title: 'test deck', repositories: []) }
    let(:current_account) { Account.new(id: 1) }

    it { expect(rendered).to match 'Add github repository to deck' }
  end

  context 'when random user open the deck' do
    let(:deck) { Deck.new(account_id: 2, title: 'test deck', repositories: []) }
    let(:current_account) { Account.new(id: 1) }

    it { expect(rendered).to_not match 'Add github repository to deck' }
  end

  context '#delete_repository_button' do
    let(:deck) { Deck.new }

    it { expect(view.delete_repository_button(1).to_s).to_not eq '' }
  end

  context '#add_repository_form' do
    it { expect(view.add_repository_form).to have_method(:post) }
    it { expect(view.add_repository_form).to have_action('/repositories') }
  end
end
