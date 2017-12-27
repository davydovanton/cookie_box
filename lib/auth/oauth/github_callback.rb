module Auth
  module Oauth
    class GithubCallback < WebBouncer::OauthCallback
      def call(oauth_response)
        account = account_repo.find_by_uid(oauth_response['uid'])
        account = account_repo.create(oauth_data(oauth_response)) unless account
        Right(account)
      end

    private

      def account_repo
        @account_repo ||= AccountRepository.new
      end

      def oauth_data(data)
        {
          uid:        data['uid'],
          login:      data['info']['nickname'],
          email:      data['info']['email'],
          name:       data['info']['name'],
          avatar_url: data['info']['image']
        }
      end
    end
  end
end
