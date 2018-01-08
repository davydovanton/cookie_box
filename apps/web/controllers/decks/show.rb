module Web::Controllers::Decks
  class Show
    include Web::Action
    include Import[operation: 'decks.operations.show', get_issues: 'decks.operations.all_issues']

    expose :deck, :issues

    def call(params)
      operation.call(params[:id]).fmap { |value| @deck = value }
      get_issues.call(deck_id: params[:id]).fmap { |value| @issues = value }
      status 404, 'Not found' if deck_protected?
    end

  private

    def deck_protected?
      return if @deck&.published
      @deck.nil? || @deck.account_id != current_account&.id
    end
  end
end
