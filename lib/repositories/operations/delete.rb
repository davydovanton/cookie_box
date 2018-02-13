# frozen_string_literal: true

module Repositories
  module Operations
    class Delete < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import['repositories.deck_repo']

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repository_id).filled(:int?)
      end

      def call(payload)
        payload = yield VALIDATOR.call(payload).to_either

        Right(deck_repo.delete_from_deck(payload[:deck_id], payload[:repository_id]))
      end
    end
  end
end
