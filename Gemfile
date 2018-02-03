source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.1'
gem 'hanami-model', '~> 1.1'
gem 'bootsnap', require: false

gem 'pg'
gem 'redis', '~>3.2'
gem 'hiredis'
gem 'mock_redis'
gem 'connection_pool'

# background
gem 'sidekiq'

# dependencies and DI
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'
gem 'hanami-interactor-matcher', github: 'davydovanton/hanami-interactor-matcher'
gem 'dry-transaction'
gem 'dry-monads', github: 'dry-rb/dry-monads'

# auth
gem 'omniauth'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'web_bouncer',     github: 'davydovanton/web_bouncer'
gem 'kan'

# frontend
gem 'slim'

gem 'hanami-webpack', github: 'samuelsimoes/hanami-webpack'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'database_cleaner'
end

group :test do
  gem 'rspec'
  gem 'rspec-hanami', github: 'davydovanton/rspec-hanami'
  gem 'vcr'
  gem 'webmock'
  gem 'faker'
  gem 'hanami-fabrication'
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :production do
  # gem 'puma'
end
