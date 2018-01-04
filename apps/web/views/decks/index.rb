module Web::Views::Decks
  class Index
    include Web::View

    def form
      form_for deck_form, id: 'deck-form' do
        text_field :title
        submit 'Add new deck'
      end
    end

    def deck_form
      Form.new(:deck, routes.decks_path, { method: :post })
    end

    def archive_form(deck)
      html.form(action: "/decks/#{deck.id}", method: "POST") do
        input(type: "hidden", name: "_method", value: "DELETE")
        input(type: "hidden", name: "id",      value: deck.id)
        input(type: "submit", value: "Archive")
      end
    end

    def publish_button(deck)
      return unless deck.published

      form_for Form.new(:deck, routes.published_decks_path, { method: :post }), id: 'deck-form' do
        hidden_field :id, value: deck.id
        submit 'Publish'
      end
    end
  end
end
