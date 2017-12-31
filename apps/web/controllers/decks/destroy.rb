module Web::Controllers::Decks
  class Destroy
    include Web::Action
    include Import[operation: 'decks.operations.archive']

    before :authenticate!

    def call(params)
      operation.call(deck_id: params[:id])
      redirect_to routes.decks_path
    end
  end
end
