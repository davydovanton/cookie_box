# frozen_string_literal: true

module Decks
  module Operations
    class Show < Core::Operation
      include Import['events', deck_repo: 'repositories.deck']

      def call(slug)
        deck = deck_repo.find_by_slug_with_repos(slug)
        return Left(:not_found) unless deck

        issues = events.broadcast('issues.list', deck_id: deck.id).first
        Right(deck: deck, issues: issues.value!)
      end
    end
  end
end
