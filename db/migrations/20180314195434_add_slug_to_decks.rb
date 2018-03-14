Hanami::Model.migration do
  change do
    add_column :decks, :slug, String, null: false, unique: true
  end
end
