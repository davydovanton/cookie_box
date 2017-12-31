module Web::Controllers::Decks
  class Show
    include Web::Action
    include Import[operation: 'decks.operations.show']

    before :authenticate!
    expose :deck

    def call(params)
      operation.call(params[:id]).fmap { |value| @deck = value }
      self.status = 404 if @deck.nil? || @deck.account_id != current_account.id
    end
  end
end
