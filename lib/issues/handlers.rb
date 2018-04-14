# frozen_string_literal: true

Container['domain_transport'].subscribe('issues.list') do |payload|
  Container['issues.operations.list'].call(payload)
end
