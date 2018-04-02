# frozen_string_literal: true

require 'dry/monads/either'

module Repositories
  module Libs
    class GithubIssues
      include Dry::Monads::Either::Mixin
      include Import['core.http_request']

      GITHUB_ISSUE_API_URL = 'https://api.github.com/repos/%{full_name}/issues?state=all&filter=all&per_page=100'

      def call(repository)
        response = http_request.get(format(GITHUB_ISSUE_API_URL, full_name: repository.full_name))
        return Left(:invalid_repo_name) unless response.is_a?(Net::HTTPSuccess)

        data =
          JSON
          .parse(response.body)
          .select { |d| d['pull_request'].nil? }
          .map { |payload| format_payload(payload) }
        Right(data)
      end

      private

      def format_payload(payload) # rubocop:disable Metrics/MethodLength
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
    end
  end
end
