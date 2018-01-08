module Decks
  module Operations
    class AllIssue < Core::Operation
      include Import['repositories.issue']

      # TODO: specs
      def call(deck_id:)
        Right(issue.all_for_deck(deck_id))
      end
    end
  end
end
