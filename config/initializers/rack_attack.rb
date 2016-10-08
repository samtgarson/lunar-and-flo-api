class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Allow all local traffic
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Allow an IP address to make 5 requests every 5 seconds
  throttle('req/ip', limit: 5, period: 5, &:ip)

  # Send the following response to throttled clients
  self.throttled_response = lambda do |env|
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      { 'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s },
      [{ error: 'Throttle limit reached. Retry later.' }.to_json]
    ]
  end
end
