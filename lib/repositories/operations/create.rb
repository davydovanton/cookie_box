module Repositories
  module Operations
    class Create < Core::Operation
      include Import[
        'repositories.deck_repo', 'repositories.libs.get_or_create_repo', 'issues.workers.export'
      ]

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repo_name).filled(:str?)
      end

      def call(deck_id, repo_name)
        result = VALIDATOR.call(deck_id: deck_id, repo_name: repo_name).to_either
        return result if result.left?

        get_or_create_repo.call(repo_name).fmap do |repo|
          deck_repo.create(deck_id: deck_id, repository_id: repo.id)
          export.perform_async(repo.id)
        end
      end
    end
  end
end
