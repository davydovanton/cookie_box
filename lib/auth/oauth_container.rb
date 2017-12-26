require_relative './oauth/github_callback'

class WebBouncer::OauthContainer
  register 'oauth.github_callback', GithubCallback
end
