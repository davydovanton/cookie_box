# frozen_string_literal: true

module Decks
  module Operations
    class Show < Core::Operation
      include Import['logger', 'domain_caller', deck_repo: 'repositories.deck']

      def call(slug)
        deck = deck_repo.find_by_slug_with_repos(slug)
        return Failure(:not_found) unless deck

        # TODO: call it in app
        issues = domain_caller.call('issues.list', deck_id: deck.id)

        case issues
        when Success
          Success(deck: deck, issues: issues.value!)
        when Failure
          logger.info("No issues for deck##{deck.id}")

          Success(deck: deck, issues: {})
        end
      end
    end
  end
end
