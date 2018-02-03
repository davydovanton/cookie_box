# frozen_string_literal: true

require 'dry/monads/either'
require 'dry/matcher/either_matcher'

require 'dry-matcher'

module Core
  class Operation
    include Dry::Monads::Either::Mixin

    Dry::Validation.load_extensions(:monads)
  end
end
