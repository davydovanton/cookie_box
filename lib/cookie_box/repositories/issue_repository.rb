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

  def update_from_vcs(vsc_id, repository_full_name, payload)
    issue = find_by_vcs_source(vsc_id)

    if issue
      update(issue.id, payload)
    else
      repository = repositories.where(full_name: repository_full_name).one!
      create(repository_id: repository.id, vcs_source_id: vsc_id, **payload)
    end
  end

  def find_by_vcs_source(vsc_id)
    root.where(vcs_source_id: vsc_id).map_to(Issue).one
  end
end
