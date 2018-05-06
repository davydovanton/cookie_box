# frozen_string_literal: true

module Decks
  module Abilities
    class Anonymous
      include Kan::Abilities

      role(:anonymous) { |account, _| account.roles.nil? }

      register('read') { |_account, deck| !!deck&.published } # rubocop:disable Style/DoubleNegation
      register('create') { |_account, _| false }
    end
  end
end
