# frozen_string_literal: true

module Decks
  module Operations
    class Create < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import['repositories.deck']

      VALIDATOR = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:account_id).filled(:int?)
      end

      def call(payload)
        data = yield validate(payload)
        result = yield persist(data)
        Success(result)
      end

      def validate(payload)
        VALIDATOR.call(payload).to_either
      end

      def persist(payload)
        Success(deck.create(payload))
      end
    end
  end
end
