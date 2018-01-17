module Issues
  module Workers
    class Export
      include Sidekiq::Worker
      include Import[operation: 'issues.operations.export']

      def perform(repository_id)
        operation.call(repository_id)
      end
    end
  end
end
