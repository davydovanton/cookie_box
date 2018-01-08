module Issues
  module Operations
    class Export < Core::Operation
      # include Import['repositories.issues', 'repositories.libs.get_or_create_repo']

      def call(repository_id)
        Right(:ok)
      end
    end
  end
end
