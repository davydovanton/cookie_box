
# frozen_string_literal: true

Container.finalize(:github_client) do |container|
  conn = Faraday.new(url: 'https://api.github.com/repos')

  container.register(:github_client, conn)
end
