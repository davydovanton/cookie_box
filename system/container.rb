# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/hanami'

class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  use :bootsnap
  use :env

  #  Core
  register_folder! 'cookie_box/core'
  register_folder! 'cookie_box/repositories'

  #  Decks
  register_folder! 'decks/operations'

  #  Repositories
  register_folder! 'repositories/operations'
  register_folder! 'repositories/libs'

  #  Issues
  register_folder! 'issues/operations'
  register_folder! 'issues/libs'
  register_folder! 'issues/workers', resolver: ->(k) { k }

  configure do |config|
    config.env = Hanami.env
  end
end
