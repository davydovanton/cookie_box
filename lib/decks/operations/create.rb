require 'dry/transaction'

module Decks
  module Operations
    class Create < Core::Operation
      include Dry::Transaction
      include Import['repositories.deck']

      VALIDATOR = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:account_id).filled(:int?)
      end

      step :validate
      step :persist

      def validate(payload)
        VALIDATOR.call(payload).to_either
      end

      def persist(payload)
        Right(deck.create(payload))
      end
    end
  end
end
