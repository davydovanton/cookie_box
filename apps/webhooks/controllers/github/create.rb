# frozen_string_literal: true

module Webhooks::Controllers::Github
  class Create
    include Webhooks::Action

    def call(_params)
      self.body = '{}'
    end
  end
end
