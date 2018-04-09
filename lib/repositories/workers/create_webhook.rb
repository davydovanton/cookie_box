# frozen_string_literal: true

module Repositories
  module Workers
    class CreateWebhook
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[:logger, operation: 'repositories.operations.create_webhook']

      def perform(repository_id)
        case result = operation.call(repository_id: repository_id)
        when Failure
          logger.info "#{result.failure.inspect} repository_id: #{repository_id}"
        end
      end
    end
  end
end
