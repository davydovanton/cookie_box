# frozen_string_literal: true

module Decks
  module Operations
    class Show < Core::Operation
      include Import['repositories.deck']

      def call(id)
        result = deck.find_with_repos(id)
        result ? Right(result) : Left(:not_found)
      end
    end
  end
end
