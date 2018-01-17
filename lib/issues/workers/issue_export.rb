module Issues
  module Workers
    class IssueExport
      include Sidekiq::Worker
      include Import[operation: 'issues.operations.export']

      def perform(repository_id)
        operation.call(repository_id)
      end
    end
  end
end
