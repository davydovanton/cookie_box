module Web::Views::Decks
  class Show
    include Web::View

    def delete_repository_button(repository_id)
      html.form(action: "/repositories/#{repository_id}", method: "POST") do
        input(type: "hidden", name: "_method", value: "DELETE")
        input(type: "hidden", name: "deck_id", value: deck.id)

        input(type: "submit", value: "Delete Repository")
      end
    end

    def add_repository_form
      form_for deck_form, id: 'deck-form' do
        text_field :name
        hidden_field :deck_id, value: deck.id

        submit 'Add github repository to deck'
      end
    end

    def deck_form
      Form.new(:repository, routes.repositories_path, { method: :post })
    end
  end
end
