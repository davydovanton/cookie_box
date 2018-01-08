require 'dry/monads/either'

module Repositories
  module Libs
    class GithubIssues
      include Dry::Monads::Either::Mixin
      include Import['core.http_request']

      GITHUB_ISSUE_API_URL = 'https://api.github.com/repos/%{full_name}/issues?state=all&filter=all&per_page=100'.freeze

      def call(repository)
        response = http_request.get(GITHUB_ISSUE_API_URL % { full_name: repository.full_name })
        return Left(:invalid_repo_name) unless response.is_a?(Net::HTTPSuccess)

        data = JSON.parse(response.body).select { |d| d['pull_request'].nil? }
        Right(data)
      end
    end
  end
end
