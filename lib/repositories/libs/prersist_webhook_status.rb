# frozen_string_literal: true

require 'dry/monads/either'

module Repositories
  module Libs
    class PrersistWebhookStatus
      include Dry::Monads::Either::Mixin

      def call(payload)
        Right(:ok)
      end
    end
  end
end
