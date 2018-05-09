# frozen_string_literal: true

module Webhooks::Controllers::Github
  class Create
    include Webhooks::Action
    include Import[operation: 'issues.operations.update']

    def call(_params)
      # TODO: log operation call
      # operation.call(params)
      self.body = '{}'
    end
  end
end
