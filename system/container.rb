require 'dry/system/container'
require 'dry/system/hanami'

class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  #  Core
  register_folder! 'cookie_box/repositories'

  #  Decks
  register_folder! 'decks/operations'

  configure
end
