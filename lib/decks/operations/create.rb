module Decks
  module Operations
    class Create < Core::Operation
      include Import['repositories.deck']

      VALIDATOR = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:account_id).filled(:int?)
      end

      def call(payload)
        VALIDATOR.call(payload).to_either.fmap { |p| deck.create(p) }
      end
    end
  end
end
