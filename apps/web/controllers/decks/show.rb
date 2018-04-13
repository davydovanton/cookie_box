# frozen_string_literal: true

module Web::Controllers::Decks
  class Show
    include Web::Action
    include Import[:abilities, operation: 'decks.operations.show']

    expose :deck, :issues

    def call(params)
      operation.call(params[:id]).fmap do |payload|
        @deck = payload[:deck]
        @issues = payload[:issues]
      end

      status 404, 'Not found' unless abilities['deck.read'].call(current_account, @deck)
    end
  end
end
