# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    has_many :decks
  end

  def find_by_uid(uid)
    root.where(uid: uid).map_to(Account).one
  end
end
