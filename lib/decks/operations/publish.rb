module Decks
  module Operations
    class Publish < Core::Operation
      include Import['repositories.deck']

      VALIDATOR = Dry::Validation.Form do
        required(:id).filled(:int?)
      end

      def call(id)
        VALIDATOR.call(id: id).to_either.fmap { |p| deck.publish(p[:id]) }
      end
    end
  end
end
