# frozen_string_literal: true

module Decks
  module Abilities
    class Base
      include Kan::Abilities

      role(:regular) do |account, _|
        account.roles.nil? || account.roles == 'regular'
      end

      ALLOWED_DECK_COUNT = 3

      register 'read' do |account, deck|
        deck&.published || (deck && deck.account_id == account&.id)
      end

      register 'create' do |account, deck_count|
        deck_count >= 0 && deck_count <= ALLOWED_DECK_COUNT
      end
    end
  end
end
