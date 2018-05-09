# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  relations :accounts, :decks, :deck_repos, :repositories

  associations do
    has_many :decks
  end

  def find_by_uid(uid)
    root.where(uid: uid).map_to(Account).one
  end

  # TODO: SPECS
  def owner_for_repository(repository_id)
    root
      .join(:decks)
      .join(:deck_repos, deck_id: :id)
      .where(deck_repos[:repository_id].qualified => repository_id)
      .limit(1).map_to(Account).one
  end
end
