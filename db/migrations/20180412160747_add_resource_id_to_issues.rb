Hanami::Model.migration do
  change do
    alter_table :issues do
      add_column :vcs_source_id, Integer
    end

    add_index :issues, :vcs_source_id, unique: true
  end
end
