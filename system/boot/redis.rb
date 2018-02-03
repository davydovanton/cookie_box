# frozen_string_literal: true

Container.finalize('persistance.redis') do |container|
  uri = URI.parse(ENV.fetch('REDISTOGO_URL', ''))
  redis = ConnectionPool.new(size: 10, timeout: 3) do
    Redis.new(driver: :hiredis, host: uri.host, port: uri.port, password: uri.password)
  end

  container.register('persistance.redis', redis)
end
