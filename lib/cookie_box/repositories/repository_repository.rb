class RepositoryRepository < Hanami::Repository
  associations do
    has_many :decks, through: :deck_repos
    has_many :issues
  end

  def find_by_name(name)
    root.where(full_name: name).map_to(Repository).one
  end
end
