# frozen_string_literal: true

require 'dry-types'

module Types
  include Dry::Types.module

  AccountRoles = String.enum('regular', 'advanced', 'admin')
end
