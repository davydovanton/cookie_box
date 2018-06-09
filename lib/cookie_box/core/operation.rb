# frozen_string_literal: true

require 'dry/monads/either'
require 'dry/matcher/either_matcher'

require 'dry-matcher'

module Core
  class Operation
    include Dry::Monads::Result::Mixin

    Dry::Validation.load_extensions(:monads)
  end
end
