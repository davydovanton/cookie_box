# frozen_string_literal: true

module Repositories
  module Libs
    class GetOrCreateRepo
      include Dry::Monads::Either::Mixin
      include Import[
        'repositories.repository', 'repositories.libs.github_info_getter', 'issues.workers.export'
      ]

      def call(repo_name)
        repo = repository.find_by_name(repo_name)

        if repo
          Right(repo)
        else
          github_info_getter.call(repo_name).fmap { |value| create_repository(value) }
        end
      end

      private

      def create_repository(payload)
        entity = repository.create(payload)
        export.perform_async(entity.id)
        entity
      end
    end
  end
end
