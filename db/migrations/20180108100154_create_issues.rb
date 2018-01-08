Hanami::Model.migration do
  change do
    create_table :issues do
      primary_key :id

      foreign_key :repository_id, :repositories, on_delete: :cascade, null: false

      column :title,    String,    null: false
      column :html_url, String,    null: false
      column :state,    String,    null: false
      column :comments, Integer,   default: 0
      column :locked,   TrueClass, default: false

      column :labels, :jsonb
      column :author, :jsonb
      column :assignees, :jsonb

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :closed_at,  DateTime
    end
  end
end
