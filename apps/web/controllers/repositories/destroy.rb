module Web::Controllers::Repositories
  class Destroy
    include Web::Action
    include Import[operation: 'repositories.operations.delete']

    before :authenticate!

    def call(params)
      operation.call(params[:repository][:deck_id], params[:repository][:id])
      redirect_to routes.deck_path(params[:repository][:deck_id])
    end
  end
end
