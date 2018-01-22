module Issues
  module Operations
    class Export < Core::Operation
      include Import[
        'repositories.repository', 'repositories.issue',
        'issues.libs.github_list', :logger
      ]

      def call(repository_id)
        repo_entity = repository.find(repository_id)
        return Left(:not_found) unless repo_entity

        github_list.call(repo_entity).fmap do |issues_payload|
          issues_payload.each { |payload| create_issue(repository_id: repository_id, **payload) }
        end
      end

      def create_issue(payload)
        issue.create(payload)
      rescue Hanami::Model::UniqueConstraintViolationError
        logger.error "Issue alredy exist: #{payload[:html_url]}"
      end
    end
  end
end
