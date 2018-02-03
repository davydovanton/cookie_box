require 'dry/transaction'

module Repositories
  module Operations
    class Create < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import['repositories.deck_repo', 'repositories.libs.get_or_create_repo']

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repo_name).filled(:str?)
      end

      def call(payload)
        payload = yield VALIDATOR.call(payload).to_either
        repo = yield get_or_create_repo.call(payload[:repo_name])

        Right(persist(repo, payload))
      end

      def persist(repo, payload)
        deck_repo.select_or_create(deck_id: payload[:deck_id], repository_id: repo.id)
      end
    end
  end
end
