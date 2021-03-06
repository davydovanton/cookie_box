# frozen_string_literal: true

module Web::Views::Decks
  class Show
    include Web::View

    def link_to_repository(repo)
      link_to repo.full_name, repo.html_url
    end

    def delete_repository_button(repository_id)
      html.form(action: "/repositories/#{repository_id}", method: 'POST') do
        input type: 'hidden', name: '_method', value: 'DELETE'
        input type: 'hidden', name: 'deck_id', value: deck.id
        input type: 'hidden', name: 'deck_slug', value: deck.slug

        input type: 'submit', value: '✕'
      end
    end

    def add_repository_form
      form_for deck_form, id: 'deck-form' do
        text_field :name, placeholder: 'github.com/username/repo'
        hidden_field :deck_id, value: deck.id
        hidden_field :deck_slug, value: deck.slug

        submit 'Add github repository to deck'
      end
    end

    def deck_form
      Form.new(:repository, routes.repositories_path, method: :post)
    end
  end
end
