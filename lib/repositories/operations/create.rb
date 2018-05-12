# frozen_string_literal: true

module Repositories
  module Operations
    class Create < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import['repositories.deck_repo', 'repositories.libs.get_or_create_repo']

      GITHUB_LINK = %r{\A(https?://)?(www.)?(github.com/)?\w+/\w+\z}

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repo_name).filled(:str?, format?: GITHUB_LINK)
      end

      def call(payload)
        payload = yield VALIDATOR.call(payload).to_either
        repo = yield get_or_create_repo.call(payload[:repo_name])
        deck = yield Success(persist(repo, payload))

        Workers::CreateWebhook.perform_async(repo.id)

        Success(deck)
      end

      def persist(repo, payload)
        deck_repo.select_or_create(deck_id: payload[:deck_id], repository_id: repo.id)
      end
    end
  end
end
