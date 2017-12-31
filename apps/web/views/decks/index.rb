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
  end
end
