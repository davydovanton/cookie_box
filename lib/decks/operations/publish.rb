module Decks
  module Operations
    class Publish < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import['repositories.deck']

      VALIDATOR = Dry::Validation.Form do
        required(:id).filled(:int?)
      end

      def call(id)
        data = yield validate(id: id)
        result = yield persist(data[:id])
        Success(result)
      end

      def validate(payload)
        VALIDATOR.call(payload).to_either
      end

      def persist(id)
        Success(deck.publish(id))
      end
    end
  end
end
