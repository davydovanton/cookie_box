require 'dry/transaction'

module Repositories
  module Operations
    class Create < Core::Operation
      include Dry::Transaction
      include Import['repositories.deck_repo', 'repositories.libs.get_or_create_repo']

      step :validate
      step :persist

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repo_name).filled(:str?)
      end

      def validate(payload)
        VALIDATOR.call(payload).to_either
      end

      def persist(payload)
        get_or_create_repo.call(payload[:repo_name]).fmap do |repo|
          deck_repo.create(deck_id: payload[:deck_id], repository_id: repo.id)
        end
      end
    end
  end
end
