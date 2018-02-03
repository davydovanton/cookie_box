# frozen_string_literal: true

class DeckRepoRepository < Hanami::Repository
  associations do
    belongs_to :deck
    belongs_to :repository
  end

  def delete_from_deck(deck_id, repo_id)
    root.where(deck_id: deck_id, repository_id: repo_id).delete
  end

  def select_or_create(payload)
    root.where(payload).map_to(DeckRepo).one || create(payload)
  end
end
