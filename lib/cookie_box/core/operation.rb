require 'dry/monads/either'
require 'dry/matcher/either_matcher'

require 'dry-matcher'

module Core
  class Operation
    include Dry::Monads::Either::Mixin
    include Dry::Matcher.for(:call, with: Dry::Matcher::EitherMatcher)
  end
end
