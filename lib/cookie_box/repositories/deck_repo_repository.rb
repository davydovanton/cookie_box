class DeckRepoRepository < Hanami::Repository
  associations do
    belongs_to :deck
    belongs_to :repository
  end

  def delete_from_deck(deck_id, repo_id)
    root.where(deck_id: deck_id, repository_id: repo_id).delete
  end
end
