# frozen_string_literal: true
source 'https://rubygems.org'

gem 'api-auth'
gem 'active_model_serializers'
gem 'api-pagination'
gem 'devise'
gem 'forecast_io'
gem 'forest_liana'
gem 'geokit-rails'
gem 'interactor', '~> 3.0', github: 'yjukaku/interactor', branch: 'interactor-requirements'
gem 'jwt'
gem 'kaminari'
gem 'pg', '~> 0.18'
gem 'plissken'
gem 'puma', '~> 3.0'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'versionist'

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'guard', require: false
  gem 'guard-minitest', require: false
  gem 'guard-rubocop'
  gem 'tld_length'
end

group :test do
  gem 'bourne'
  gem 'codecov', require: false
  gem 'm', '~> 1.5.0'
  gem 'minitest-reporters'
  gem 'mocha'
  gem 'simplecov', require: false
  gem 'webmock'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
