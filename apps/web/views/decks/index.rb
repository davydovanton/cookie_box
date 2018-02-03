# frozen_string_literal: true

module Web::Views::Decks
  class Index
    include Web::View

    def auth_button
      if current_account.login
        link_to 'Logout', '/auth/logout'
      else
        link_to 'Login', '/auth/github'
      end
    end

    def form
      form_for deck_form, id: 'deck-form' do
        text_field :title
        submit '+'
      end
    end

    def deck_form
      Form.new(:deck, routes.decks_path, method: :post)
    end

    def archive_form(deck)
      html.form(action: "/decks/#{deck.id}", method: 'POST') do
        input(type: 'hidden', name: '_method', value: 'DELETE')
        input(type: 'hidden', name: 'id',      value: deck.id)
        input(type: 'submit', value: '✕')
      end
    end

    def publish_button(deck)
      return if deck.published

      form_for Form.new(:deck, routes.published_decks_path, method: :post), id: 'deck-form' do
        hidden_field :id, value: deck.id
        submit 'Publish'
      end
    end

    def publish_status(deck)
      deck.published ? 'Public' : 'Private'
    end
  end
end
