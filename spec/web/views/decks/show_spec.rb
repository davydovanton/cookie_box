RSpec.describe Web::Views::Decks::Show, type: :view do
  let(:exposures) { Hash[deck: deck] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/decks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:deck)      { Deck.new(title: 'test deck', repositories: []) }

  it { expect(rendered).to match 'test deck' }
end
