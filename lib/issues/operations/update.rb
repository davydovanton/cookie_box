# frozen_string_literal: true

module Issues
  module Operations
    # TODO: rename to upset
    class Update < Core::Operation
      ISSUE_KEYS = %i[title user labels state locked assignees comments updated_at closed_at]

      def call(webhook:)
        vcs_source_id = webhook[:issue][:id]
        payload = webhook[:issue].slice(*ISSUE_KEYS)

        Success(issue_repo.update_from_vsc(vcs_source_id, payload))
      end
    end
  end
end
