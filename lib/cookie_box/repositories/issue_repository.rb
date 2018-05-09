# frozen_string_literal: true

class IssueRepository < Hanami::Repository
  relations :decks, :deck_repos, :repositories

  associations do
    belongs_to :repository
  end

  def all_for_deck(deck_id)
    aggregate(:repository)
      .join(:repositories)
      .join(:deck_repos, repositories[:id].qualified => deck_repos[:repository_id].qualified)
      .where(deck_repos[:deck_id].qualified => deck_id)
      .map_to(Issue).to_a
  end

  def update_from_vsc(vsc_id, paylaod)
    issue = find_by_vcs_source(vsc_id)

    issue ? update(issue.id, payload) : create(vsc_source_id: vsc_id, **payload)
  end

  def find_by_vcs_source(vsc_id)
    root.where(vsc_source_id: vsc_id).map_to(Issue).one
  end
end
