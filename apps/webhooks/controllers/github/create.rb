# frozen_string_literal: true

module Webhooks::Controllers::Github
  class Create
    include Webhooks::Action
    include Import[operation: 'issues.operations.update']

    def call(params)
      # TODO: log operation call

      # First repository hook contain [:zen, :hook_id, :hook, :repository, :sender] keys and we need to miss it.
      operation.call(webhook: params.to_h) if params[:issue]
      self.body = '{}'
    end
  end
end
