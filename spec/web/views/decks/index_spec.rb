# frozen_string_literal: true

RSpec.describe Web::Views::Decks::Index, type: :view do
  let(:exposures) { { params: params } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/decks/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:params) { {} }

  context '#form' do
    it { expect(view.form).to have_method(:post) }
    it { expect(view.form).to have_action('/decks') }
  end

  context '#archive_form' do
    let(:deck) { Deck.new(published: true) }

    it { expect(view.archive_form(deck).to_s).to_not eq '' }
  end

  context '#publish_button' do
    context 'when deck not published' do
      let(:deck) { Deck.new(published: true) }

      it { expect(view.publish_button(deck)).to eq nil }
    end

    context 'when deck not published' do
      let(:deck) { Deck.new(published: false) }

      it { expect(view.publish_button(deck)).to have_method(:post) }
      it { expect(view.publish_button(deck)).to have_action('/published_decks') }
    end
  end
end
