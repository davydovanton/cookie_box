module Web::Controllers::Decks
  class Index
    include Web::Action
    include Import[operation: 'decks.operations.list']

    before :authenticate!
    expose :decks

    def call(params)
      operation.call(current_account.id)
        .bind { |value| @decks = value }
    end
  end
end
