# frozen_string_literal: true

module Decks
  module Operations
    class Archive < Core::Operation
      include Import[repository: 'repositories.deck']

      def call(deck_slug:, account_id:)
        deck = repository.find_by_slug(deck_slug)
        repository.archive(deck.id) if deck&.account_id == account_id

        Success(:ok)
      end
    end
  end
end
