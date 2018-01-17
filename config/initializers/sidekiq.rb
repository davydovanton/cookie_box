Sidekiq.configure_server do |config|
  config.redis = Container['persistance.redis']
end

Sidekiq.configure_client do |config|
  config.redis = Container['persistance.redis']
end
