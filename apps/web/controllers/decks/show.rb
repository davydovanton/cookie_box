# frozen_string_literal: true

module Web::Controllers::Decks
  class Show
    include Web::Action
    include Import[:abilities, operation: 'decks.operations.show', get_issues: 'decks.operations.all_issues']

    expose :deck, :issues

    def call(params)
      operation.call(params[:id]).fmap { |value| @deck = value }
      get_issues.call(deck_id: params[:id]).fmap { |value| @issues = value }

      status 404, 'Not found' unless abilities['deck.read'].call(current_account, @deck)
    end
  end
end
