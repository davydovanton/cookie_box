module Issues
  module Operations
    class Export < Core::Operation
      include Dry::Monads::Do.for(:call)

      include Import[
        'repositories.repository', 'repositories.issue',
        'issues.libs.github_list', :logger
      ]

      def call(repository_id)
        entity = yield find(repository_id)
        issues = yield github_list.call(entity)

        Right(persist_issues(issues, repository_id))
      end

    private

      def find(id)
        entity = repository.find(id)
        entity ? Right(entity) : Left(:not_found)
      end

      def persist_issues(issues, repository_id)
        issues.each { |payload| create_issue(repository_id: repository_id, **payload) }
      end

      def create_issue(payload)
        issue.create(payload)
      rescue Hanami::Model::UniqueConstraintViolationError
        logger.error "Issue alredy exist: #{payload[:html_url]}"
      end
    end
  end
end
