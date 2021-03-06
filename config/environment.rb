# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../system/import'
# TODO: Do we really need this require?
# require_relative '../lib/cookie_box'

Hanami.configure do # rubocop:disable Metrics/BlockLength
  if Hanami.app?(:webhooks)
    require_relative '../apps/webhooks/application'
    mount Webhooks::Application, at: '/webhooks'
  end

  if Hanami.app?(:web)
    require_relative '../apps/web/application'
    mount Web::Application, at: '/'
  end

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/cookie_box_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/cookie_box_development'
    #    adapter :sql, 'mysql://localhost/cookie_box_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/cookie_box/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :test do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug, stream: StringIO.new
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
