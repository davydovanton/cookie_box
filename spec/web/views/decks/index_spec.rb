RSpec.describe Web::Views::Decks::Index, type: :view do
  let(:exposures) { Hash[params: {}] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/decks/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  context '#form' do
    it { expect(view.form).to have_method(:post) }
    it { expect(view.form).to have_action('/decks') }
  end
end
