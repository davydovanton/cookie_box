# frozen_string_literal: true

module Decks
  module Operations
    class Create < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import['repositories.deck', 'decks.libs.slug_generator']

      VALIDATOR = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:account_id).filled(:int?)
      end

      def call(payload)
        payload = yield validate(payload)
        payload = yield generate_slug(payload)
        result = yield persist(payload)
        Success(result)
      end

      def validate(payload)
        VALIDATOR.call(payload).to_either
      end

      def generate_slug(payload)
        Success(slug: slug_generator.call, **payload)
      end

      def persist(payload)
        Success(deck.create(payload))
      end
    end
  end
end
