module Decks
  module Operations
    class Show < Core::Operation
      include Import['repositories.deck']

      def call(id)
        result = deck.find(id)
        result ? Right(result) : Left(:not_found)
      end
    end
  end
end
