# frozen_string_literal: true

module Issues
  module Operations
    class List < Core::Operation
      include Import[issue_repo: 'repositories.issue']

      def call(deck_id:)
        groupped_issues = issue_repo.all_for_deck(deck_id).group_by { |entity| entity.state.to_sym }

        Right(groupped_issues)
      end
    end
  end
end
