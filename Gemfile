source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'figaro'
gem 'faraday'
gem "active_model_serializers", github: "rails-api/active_model_serializers"
gem 'jwt'
gem 'sidekiq'
gem 'rack-protection', '~> 2.0', github: 'sinatra/rack-protection', require: false
gem 'sinatra', github: 'sinatra'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
