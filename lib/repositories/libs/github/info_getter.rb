# frozen_string_literal: true

require 'dry/monads/either'

module Repositories
  module Libs
    module Github
      class InfoGetter
        include Dry::Monads::Result::Mixin
        include Import[:github_client]

        def call(repo_name)
          response = github_client.get("/repos/#{repo_name}")
          return Failure(:invalid_repo_name) unless response.success?

          data = JSON.parse(response.body)

          Success(
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
