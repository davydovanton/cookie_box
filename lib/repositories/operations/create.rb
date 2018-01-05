module Repositories
  module Operations
    class Create < Core::Operation
      include Import['repositories.repository']

      VALIDATOR = Dry::Validation.Form do
        required(:title).filled(:str?)
      end

      def call(deck_id, payload)
      end
    end
  end
end
