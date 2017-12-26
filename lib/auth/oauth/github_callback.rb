class GithubCallback < WebBouncer::OauthCallback
  def call(oauth_response)
    login = oauth_response['extra']['raw_info']['login']

    if login
      p oauth_response['extra']['raw_info']

      Right(login)
    else
      Left(:not_found)
    end
  end
end
