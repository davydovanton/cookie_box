Fabricator(:deck_repo) do
  deck_id { Fabricate.create(:deck).id }
  repository_id { Fabricate.create(:repository).id }
end
