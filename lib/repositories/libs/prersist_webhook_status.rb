# frozen_string_literal: true

require 'dry/monads/either'

module Repositories
  module Libs
    class PrersistWebhookStatus
      include Dry::Monads::Result::Mixin

      include Import['repositories.repository']

      def call(repository_id:, webhook_owner_id:)
        # TODO: log updating
        Success(repository.update(repository_id, webhook_enable: true, webhook_owner_id: webhook_owner_id))
      end
    end
  end
end
