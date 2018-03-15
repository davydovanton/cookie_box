# frozen_string_literal: true

module Web::Controllers::Decks
  class Destroy
    include Web::Action
    include Import[operation: 'decks.operations.archive']

    before :authenticate!

    def call(params)
      operation.call(deck_slug: params[:id], account_id: current_account.id)
      redirect_to routes.decks_path
    end

    private

    def verify_csrf_token?
      false
    end
  end
end
