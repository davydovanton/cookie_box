# frozen_string_literal: true

module Repositories
  module Abilities
    class Regular
      include Kan::Abilities

      role(:regular) do |account, _|
        account.roles.nil? || account.roles == 'regular'
      end

      ALLOWED_REPOSITORIES_COUNT = 7

      register 'create' do |_account, repositories_count|
        repositories_count >= 0 && repositories_count <= ALLOWED_REPOSITORIES_COUNT
      end
    end
  end
end
