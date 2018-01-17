module Decks
  module Operations
    class AllIssue < Core::Operation
      include Import['repositories.issue']

      # THINK: replace this operation to issues domain 'issues.operations.list'
      def call(deck_id:)
        groupped_issues = issue
          .all_for_deck(deck_id)
          .group_by { |entity| entity.state.to_sym }

        Right(groupped_issues)
      end
    end
  end
end
