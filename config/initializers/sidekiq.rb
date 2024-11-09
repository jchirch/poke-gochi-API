Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }

  config.options[:concurrency] = 6
end
  
Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] } 
end
  