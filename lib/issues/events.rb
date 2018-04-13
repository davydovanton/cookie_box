Container['events'].subscribe('issues.list') do |payload|
  Container['issues.operations.list'].call(payload)
end


