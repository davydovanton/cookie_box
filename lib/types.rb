# frozen_string_literal: true

require 'dry-types'

module Types
  include Dry::Types.module

  AccountRoles = String.enum('regular', 'advanced', 'admin')
  GithubWebhookHandlerUrl = String.default('http://cookie-box.cluster.davydovanton.com/webhooks/github')
end
