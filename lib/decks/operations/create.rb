module Decks
  module Operations
    class Create < Core::Operation
      include Import['repositories.deck']

      VALIDATOR = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:account_id).filled(:int?)
      end

      def call(payload)
        result = VALIDATOR.call(payload)

        if result.success?
          Right(deck.create(payload))
        else
          Left([:invalid_data, result.messages])
        end
      end
    end
  end
end
