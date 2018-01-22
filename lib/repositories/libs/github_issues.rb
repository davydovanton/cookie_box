require 'dry/monads/either'

module Repositories
  module Libs
    class GithubIssue
      include Dry::Monads::Either::Mixin
      include Import['core.http_request']

      GITHUB_ISSUE_API_URL = 'https://api.github.com/repos/%{full_name}/issues?state=all&filter=all&per_page=100'.freeze

      def call(repository)
        response = http_request.get(GITHUB_ISSUE_API_URL % { full_name: repository.full_name })
        return Left(:invalid_repo_name) unless response.is_a?(Net::HTTPSuccess)

        data = JSON.parse(response.body).select { |d| d['pull_request'].nil? }.map do |payload|
          {
            title: payload['title'],
            html_url: payload['html_url'],
            state: payload['state'],
            comments: payload['comments'],
            locked: payload['locked'],
            labels: payload['labels'],
            author: payload['user'],
            assignees: payload['assignees'],
            created_at: payload['created_at'],
            closed_at: payload['closed_at']
          }
        end
        Right(data)
      end
    end
  end
end
