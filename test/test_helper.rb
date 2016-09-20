ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'codecov'
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end
SimpleCov.start 'rails' do
  add_group 'Interactors', 'app/interactors'
  add_group 'Serializers', 'app/serializers'
end
SimpleCov.formatter = SimpleCov::Formatter::Codecov if ENV['CODECOV_TOKEN']

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'mocha/mini_test'
require 'webmock/minitest'
require 'minitest/reporters'

WebMock.disable_net_connect!(allow_localhost: true)

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include RequestHelpers
  include MockHelpers
  include CheckInHelpers
  include TaskHelpers

  setup do
    mock_http
  end
end
