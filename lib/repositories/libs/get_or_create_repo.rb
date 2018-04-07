# frozen_string_literal: true

module Repositories
  module Libs
    class GetOrCreateRepo
      include Dry::Monads::Either::Mixin
      include Import[
        'repositories.repository', 'repositories.libs.github.info_getter', 'issues.workers.export'
      ]

      DELIMETER = '/'

      def call(repo_name)
        repo_name = truncate(repo_name)
        repo = repository.find_by_name(repo_name)

        if repo
          Right(repo)
        else
          info_getter.call(repo_name).fmap { |value| create_repository(value) }
        end
      end

      private

      def truncate(repo_name)
        repo_name.split(DELIMETER).last(2).join(DELIMETER)
      end

      def create_repository(payload)
        entity = repository.create(payload)
        export.perform_async(entity.id)
        entity
      end
    end
  end
end
