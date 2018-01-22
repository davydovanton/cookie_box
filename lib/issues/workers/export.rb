module Issues
  module Workers
    class Export
      include Sidekiq::Worker
      include Import[:logger, operation: 'issues.operations.export']

      def perform(repository_id)
        result = operation.call(repository_id)

        if result.left?
          logger.info "#{result.value.inspect} repository_id: #{repository_id}"
        end
      end
    end
  end
end
