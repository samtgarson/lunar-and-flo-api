ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
WebMock.disable_net_connect!(allow_localhost: true)

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

require 'minitest/reporters'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include RequestHelpers
  include MockHelpers

  setup do
    mock_http
  end
end
