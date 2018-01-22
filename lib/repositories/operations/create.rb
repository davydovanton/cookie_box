require 'dry/transaction'

module Repositories
  module Operations
    class Create < Core::Operation
      include Import['repositories.deck_repo', 'repositories.libs.get_or_create_repo']

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repo_name).filled(:str?)
      end

      def call(payload)
        result = VALIDATOR.call(payload).to_either
        return result if result.left?

        get_or_create_repo.call(payload[:repo_name]).fmap do |repo|
          deck_repo.create(deck_id: payload[:deck_id], repository_id: repo.id)
        end
      end
    end
  end
end
