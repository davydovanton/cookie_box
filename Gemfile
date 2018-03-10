# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.0'

gem 'bootsnap', require: false
gem 'hanami', '~> 1.1'
gem 'hanami-model', '~> 1.1'
gem 'rake'

gem 'connection_pool'
gem 'hiredis'
gem 'mock_redis'
gem 'pg'
gem 'redis', '~>3.2'

# background
gem 'sidekiq'

# dependencies and DI
gem 'dry-monads', github: 'dry-rb/dry-monads', ref: '91667c3f4ae9072b10fb35c9124e96cb3f2245e2'
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'
gem 'hanami-interactor-matcher', github: 'davydovanton/hanami-interactor-matcher'

# auth
gem 'kan'
gem 'omniauth'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'web_bouncer', github: 'davydovanton/web_bouncer'

# frontend
gem 'slim'

gem 'hanami-webpack', github: 'samuelsimoes/hanami-webpack'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'database_cleaner'
  gem 'dotenv', '~> 2.0'

  # style check
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'hanami-fabrication'
  gem 'rspec'
  gem 'rspec-hanami', github: 'davydovanton/rspec-hanami'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
  gem 'vcr'
  gem 'webmock'
end

group :production do
  # gem 'puma'
end
