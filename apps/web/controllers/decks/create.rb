# frozen_string_literal: true

module Web::Controllers::Decks
  class Create
    include Web::Action
    include Import[operation: 'decks.operations.create']

    before :authenticate!

    def call(params)
      operation.call(account_id: current_account.id, **params[:deck])
      redirect_to routes.decks_path
    end
  end
end
