# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :repositories do
      primary_key :id

      column :full_name,        String
      column :description,      String
      column :html_url,         String
      column :topics,           String
      column :webhook_owner_id, Integer, default: nil

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
