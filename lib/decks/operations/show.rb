# frozen_string_literal: true

module Decks
  module Operations
    class Show < Core::Operation
      include Import['repositories.deck']

      def call(slug)
        result = deck.find_by_slug_with_repos(slug)
        result ? Right(result) : Left(:not_found)
      end
    end
  end
end
