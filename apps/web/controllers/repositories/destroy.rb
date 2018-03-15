# frozen_string_literal: true

module Web::Controllers::Repositories
  class Destroy
    include Web::Action
    include Import[operation: 'repositories.operations.delete']

    before :authenticate!

    def call(params)
      operation.call(deck_id: params[:deck_id], repository_id: params[:id])
      redirect_to routes.deck_path(params[:deck_slug])
    end

    private

    def verify_csrf_token?
      false
    end
  end
end
