# frozen_string_literal: true

Hanami::Model.migration do
  change do
    add_column :decks, :slug, String, null: false, unique: true
  end
end
