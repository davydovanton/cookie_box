require 'dry/monads/either'

module Issues
  module Libs
    class GithubList
      include Dry::Monads::Either::Mixin
      include Import['core.http_request']

      GITHUB_ISSUE_API_URL = 'https://api.github.com/repos/%{full_name}/issues?state=all&filter=all&per_page=100&page=%{page}&client_id=%{client_id}&client_secret=%{client_secret}'.freeze

      def call(repository)
        data = []
        page = 1

        begin
          response = http_request.get(GITHUB_ISSUE_API_URL % {
            full_name: repository.full_name, page: page,
            client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET']
          })
          return Left(:invalid_repo_name) unless response.is_a?(Net::HTTPSuccess)

          page_data = JSON.parse(response.body).select { |d| d['pull_request'].nil? }.map do |payload|
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

          puts "page: #{page}, count: #{page_data.count}"

          page += 1
          data += page_data
        end while page_data.any?

        Right(data)
      end

      private

        def page_response(full_name, page)
          response = http_request.get(GITHUB_ISSUE_API_URL % { full_name: repository.full_name, page: page })
          return Left(:invalid_repo_name) unless response.is_a?(Net::HTTPSuccess)

          JSON.parse(response.body).select { |d| d['pull_request'].nil? }.map do |payload|
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
end
