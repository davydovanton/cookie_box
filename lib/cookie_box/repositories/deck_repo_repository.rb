class DeckRepoRepository < Hanami::Repository
  associations do
    belongs_to :deck
    belongs_to :repository
  end
end
