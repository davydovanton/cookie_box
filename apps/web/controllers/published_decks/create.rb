module Web::Controllers::PublishedDecks
  class Create
    include Web::Action
    include Import[operation: 'decks.operations.publish']

    before :authenticate!

    def call(params)
      # TODO: security issue. Anyone cau publish deck
      operation.call(params[:deck][:id])
      redirect_to routes.decks_path
    end
  end
end
