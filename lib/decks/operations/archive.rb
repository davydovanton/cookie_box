# frozen_string_literal: true

module Decks
  module Operations
    class Archive < Core::Operation
      include Import['repositories.deck']

      def call(deck_id:, account_id:)
        deck.archive(deck_id) if deck.find(deck_id)&.account_id == account_id

        Right(:ok)
      end
    end
  end
end
