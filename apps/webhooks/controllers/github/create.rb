# frozen_string_literal: true

module Webhooks::Controllers::Github
  class Create
    include Webhooks::Action
    inclide Import[operation: 'issues.operations.update']

    def call(params)
      # operation.call(params)
      self.body = '{}'
    end
  end
end
