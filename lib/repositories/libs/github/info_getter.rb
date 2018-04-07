# frozen_string_literal: true

require 'dry/monads/either'

module Repositories
  module Libs
    module Github
      class InfoGetter
        include Dry::Monads::Either::Mixin
        include Import['core.http_request']

        GITHUB_REPO_API_URL = 'https://api.github.com/repos/'

        def call(repo_name)
          response = http_request.get(GITHUB_REPO_API_URL + repo_name)
          return Left(:invalid_repo_name) unless response.is_a?(Net::HTTPSuccess)

          data = JSON.parse(response.body)

          Right(
            full_name: data['full_name'],
            description: data['description'],
            html_url: data['html_url'],
            topics: data['topics']
          )
        end
      end
    end
  end
end
