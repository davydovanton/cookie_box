module Decks
  module Operations
    class AllIssue < Core::Operation
      include Import['repositories.issue']

      # THINK: replace this operation to issues domain 'issues.operations.all'
      def call(deck_id:)
        Right(issue.all_for_deck(deck_id))
      end
    end
  end
end
