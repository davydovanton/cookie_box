# frozen_string_literal: true

module Web::Controllers::Repositories
  class Create
    include Web::Action
    include Import[operation: 'repositories.operations.create']

    before :authenticate!

    def call(params)
      operation.call(deck_id: params[:repository][:deck_id], repo_name: params[:repository][:name])
      redirect_to routes.deck_path(params[:repository][:deck_slug])
    end
  end
end
