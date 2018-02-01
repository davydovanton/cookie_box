module Issues
  module Workers
    class Export
      include Dry::Monads::Result::Mixin
      include Sidekiq::Worker

      include Import[:logger, operation: 'issues.operations.export']

      def perform(repository_id)
        case result = operation.call(repository_id)
        when Failure
          logger.info "#{result.value.inspect} repository_id: #{repository_id}"
        end
      end
    end
  end
end
