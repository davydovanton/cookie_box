class IssueRepository < Hanami::Repository
  relations :decks, :deck_repos, :repositories

  associations do
    belongs_to :repository
  end

  def all_for_deck(deck_id)
    root
      .join(:repositories)
      .join(:deck_repos, repositories[:id].qualified => deck_repos[:repository_id].qualified)
      .where(deck_repos[:repository_id].qualified => 1).map_to(Issue).to_a
  end
end
