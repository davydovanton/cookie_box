module Repositories
  module Libs
    class GetOrCreateRepo
      include Dry::Monads::Either::Mixin
      include Import['repositories.repository', 'repositories.libs.github_info_getter']

      def call(repo_name)
        repo = repository.find_by_name(repo_name)

        if repo
          Right(repo)
        else
          github_info_getter.call(repo_name).fmap { |value| repository.create(value) }
        end
      end
    end
  end
end
