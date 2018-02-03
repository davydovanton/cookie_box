# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :decks do
      primary_key :id

      foreign_key :account_id, :accounts, on_delete: :cascade, null: false

      column :title, String, null: false
      column :published, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :deleted_at, DateTime
    end
  end
end
