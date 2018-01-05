class RepositoryRepository < Hanami::Repository
  def find_by_name(name)
    root.where(full_name: name).map_to(Repository).one
  end
end
