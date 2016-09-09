module MockHelpers
  def mock_http
    stub_request(:any, %r{https://api.forecast.io/*})
      .to_return(body: forecast_json, status: 200)
  end

  def forecast_json
    File.read Rails.root.join('test/fixtures/forecast.json')
  end
end
