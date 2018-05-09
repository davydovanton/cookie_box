# frozen_string_literal: true

module Repositories
  module Operations
    class CreateWebhook < Core::Operation
      include Dry::Monads::Do.for(:call)
      include Dry::Monads::Maybe::Mixin

      include Import[
        'repositories.libs.github.webhook_request',
        'repositories.libs.prersist_webhook_status',
        account_repo: 'repositories.account',
        repository_repo: 'repositories.repository'
      ]

      VALIDATOR = Dry::Validation.Form do
        required(:repository_id).filled(:int?)
      end

      def call(payload)
        payload = yield VALIDATOR.call(payload).to_either
        repository = yield find_repository(payload[:repository_id])
        account = yield find_repository_owner(payload[:repository_id])

        yield webhook_request.call(token: account.token, repository: repository)
        prersist_webhook_status.call(webhook_owner_id: account.id, **payload)
        # notify
      end

      private

      def find_repository(repository_id)
        Maybe(repository_repo.find(repository_id))
      end

      def find_repository_owner(repository_id)
        Maybe(account_repo.owner_for_repository(repository_id))
      end
    end
  end
end
