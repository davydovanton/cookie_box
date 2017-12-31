module Decks
  module Operations
    class Archive < Core::Operation
      include Import['repositories.deck']

      def call(deck_id:)
        Right(deck.archive(deck_id))
      end
    end
  end
end
