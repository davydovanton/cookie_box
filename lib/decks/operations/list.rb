module Decks
  module Operations
    class List < Core::Operation
      def call(account_id)
        Right(:ok)
      end
    end
  end
end
