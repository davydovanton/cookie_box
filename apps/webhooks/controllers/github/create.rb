# frozen_string_literal: true

module Webhooks::Controllers::Github
  class Create
    include Webhooks::Action
    include Import[operation: 'issues.operations.update']

    def call(params)
      # TODO: log operation call
      operation.call(webhook: params.to_h)
      self.body = '{}'
    end
  end
end
