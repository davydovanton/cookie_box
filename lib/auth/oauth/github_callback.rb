class GithubCallback < WebBouncer::OauthCallback
  def call(oauth_response)
    result = oauth_data(oauth_response)
    Right(result)
  end

private

  def oauth_data(data)
    {
      login:     data['info']['nickname'],
      email:     data['info']['email'],
      name:      data['info']['name'],
      image_url: data['info']['image']
    }
  end
end
