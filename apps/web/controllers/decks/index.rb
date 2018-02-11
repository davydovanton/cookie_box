# frozen_string_literal: true

module Web::Controllers::Decks
  class Index
    include Dry::Monads::Result::Mixin
    include Web::Action

    include Import[operation: 'decks.operations.list']

    before :authenticate!
    expose :decks

    def call(_params)
      handle_response operation.call(current_account.id)
    end

    def handle_response(result)
      case result
      when Success then @decks = result.value!
      end
    end
  end
end
