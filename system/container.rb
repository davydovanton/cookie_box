require 'dry/system/container'
require 'dry/system/hanami'

class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  use :bootsnap

  #  Core
  register_folder! 'cookie_box/core'
  register_folder! 'cookie_box/repositories'

  #  Decks
  register_folder! 'decks/operations'

  #  Repositories
  register_folder! 'repositories/operations'
  register_folder! 'repositories/libs'

  configure
end
