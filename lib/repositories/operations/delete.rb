module Repositories
  module Operations
    class Delete < Core::Operation
      include Import['repositories.deck_repo']

      VALIDATOR = Dry::Validation.Form do
        required(:deck_id).filled(:int?)
        required(:repository_id).filled(:int?)
      end

      def call(deck_id, repository_id)
        result = VALIDATOR.call(deck_id: deck_id, repository_id: repository_id).to_either
        return result if result.left?

        Right(deck_repo.delete_from_deck(deck_id, repository_id))
      end
    end
  end
end
