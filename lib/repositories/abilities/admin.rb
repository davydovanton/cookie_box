# frozen_string_literal: true

module Repositories
  module Abilities
    class Admin
      include Kan::Abilities

      role(:admin) { |account, _| account.roles == 'admin' }

      register('create') { |_account, _| true }
    end
  end
end
