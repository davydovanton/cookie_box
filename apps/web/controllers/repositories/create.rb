module Web::Controllers::Repositories
  class Create
    include Web::Action
    include Import[operation: 'repositories.operations.create']

    before :authenticate!

    def call(params)
      operation.call(params[:repository][:deck_id], params[:repository][:name])
      redirect_to routes.deck_path(params[:repository][:deck_id])
    end
  end
end
