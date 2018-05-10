# frozen_string_literal: true

module Issues
  module Operations
    # TODO: rename to upset
    class Update < Core::Operation
      include Import[issue_repo: 'repositories.issue']

      ISSUE_KEYS = %i[title labels state locked html_url assignees comments updated_at closed_at].freeze

      def call(webhook:)
        vcs_source_id = webhook[:issue][:id]
        payload = webhook[:issue].slice(*ISSUE_KEYS)

        issue = issue_repo.update_from_vcs(
          vcs_source_id,
          webhook[:repository][:full_name],
          { author: webhook[:issue][:user] }.merge!(payload)
        )

        Success(issue)
      end
    end
  end
end
