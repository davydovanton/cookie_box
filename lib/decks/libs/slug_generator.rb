# frozen_string_literal: true

module Decks
  module Libs
    class SlugGenerator
      def call
        SecureRandom.hex[0..6]
      end
    end
  end
end
