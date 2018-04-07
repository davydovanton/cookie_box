# frozen_string_literal: true

module Repositories
  module Operations
    class CreateWebhook < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import[
        'repositories.libs.github.webhook_request',
        'repositories.libs.prersist_webhook_status'
      ]

      VALIDATOR = Dry::Validation.Form do
        required(:repository_id).filled(:int?)
      end

      def call(payload)
        payload = yield VALIDATOR.call(payload).to_either
        webhook_request.call(payload)
        prersist_webhook_status.call(payload)
        # notify
      end
    end
  end
end
