require 'dry/transaction'

module Repositories
  module Operations
    class Delete < Core::Operation
      include Dry::Transaction
      include Import['repositories.deck_repo']

      step :validate
      step :persist

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repository_id).filled(:int?)
      end

      def validate(payload)
        VALIDATOR.call(payload).to_either
      end

      def persist(payload)
        Right(deck_repo.delete_from_deck(payload[:deck_id], payload[:repository_id]))
      end
    end
  end
end
