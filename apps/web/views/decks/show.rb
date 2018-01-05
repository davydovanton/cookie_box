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
  end
end
