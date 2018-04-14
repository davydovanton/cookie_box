# frozen_string_literal: true

require 'dry/monads/either'

module Repositories
  module Libs
    module Github
      class WebhookRequest
        include Dry::Monads::Either::Mixin
        include Import['core.http_request']

        GITHUB_WEBHOOK_API_URL = 'https://api.github.com/repos/%{full_name}/hooks?access_token=%{token}'

        NEW_HOOK_PAYLOAD = {
          name: 'web',
          active: true,
          events: ['issues'],
          config: {
            url: Types::GithubWebhookHandlerUrl[ENV['GITHUB_WEBHOOK_HANDLER_URL']],
            content_type: 'json'
          }
        }.freeze

        def call(token:, repository:)
          response = http_request.post(
            format(GITHUB_WEBHOOK_API_URL, full_name: repository.full_name, token: token),
            NEW_HOOK_PAYLOAD
          )

          return Left(response.body) unless response.is_a?(Net::HTTPSuccess)

          Right(status: :ok)
        end
      end
    end
  end
end
