# frozen_string_literal: true

module Decks
  module Abilities
    class Admin
      include Kan::Abilities

      role(:admin) { |account, _| account.roles == 'admin' }

      register('read', 'create') { |_account, _| true }
    end
  end
end
