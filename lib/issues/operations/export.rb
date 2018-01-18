module Issues
  module Operations
    class Export < Core::Operation
      include Import['repositories.repository', 'repositories.issue', 'issues.libs.github_list']

      def call(repository_id)
        repo_entity = repository.find(repository_id)
        return Left(:not_found) unless repo_entity

        github_list.call(repo_entity).fmap do |issues_payload|
          issues_payload.each do |payload|
            issue.create(repository_id: repository_id, **payload)
          end
        end
      end
    end
  end
end
