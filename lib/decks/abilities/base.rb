module Decks
  module Abilities
    class Base
      include Kan::Abilities

      register 'read' do |account, deck|
        deck&.published || (deck && deck.account_id == account&.id)
      end
    end
  end
end
