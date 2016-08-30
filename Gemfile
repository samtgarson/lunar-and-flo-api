# frozen_string_literal: true
source 'https://rubygems.org'

gem 'active_model_serializers'
gem 'forest_liana'
gem 'jwt'
gem 'devise'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

group :development, :test do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'guard', require: false
  gem 'guard-minitest', require: false
  gem 'tld_length'
end

group :test do
  gem 'minitest-reporters'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
