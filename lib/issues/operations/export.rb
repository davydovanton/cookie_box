module Issues
  module Operations
    class Export < Core::Operation
      include Import['repositories.repository', 'repositories.issue', 'issues.libs.github_list']

      def call(repository_id)
        repo_entity = repository.find(repository_id)
        return Left(:not_found) unless repo_entity

        result = github_list.call(repo_entity)

        if result.right?
          result.value.each { |payload| issue.create(repository_id: repository_id, **payload) }
          Right(:ok)
        else
          result
        end
      end
    end
  end
end
