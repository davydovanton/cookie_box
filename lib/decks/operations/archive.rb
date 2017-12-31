module Decks
  module Operations
    class Archive < Core::Operation
      include Import['repositories.deck']

      def call(deck_id:)
        deck.archive(deck_id) if deck_id
        Right(:ok)
      end
    end
  end
end
