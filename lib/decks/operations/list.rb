# frozen_string_literal: true

module Decks
  module Operations
    class List < Core::Operation
      include Import['repositories.deck']

      def call(account_id)
        Success(deck.all_for_account(account_id))
      end
    end
  end
end
