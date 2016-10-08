ForecastIO.configure do |configuration|
  configuration.api_key = ENV['FORECAST_API_KEY']
  configuration.default_params = { units: 'si' }
end
