module Decks
  module Abilities
    class Base
      include Kan::Abilities

      register 'read' do |account, deck|
      end
    end
  end
end
