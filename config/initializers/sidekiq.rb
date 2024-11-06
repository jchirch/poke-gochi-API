Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'], namespace: 'poke-gotchi-api' }
end
  
Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'], namespace: 'poke-gotchi-api' } 
end
  