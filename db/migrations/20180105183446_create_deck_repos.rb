Hanami::Model.migration do
  change do
    create_table :deck_repos do
      primary_key :id

      foreign_key :deck_id, :decks, null: false
      foreign_key :repository_id, :repositories, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
