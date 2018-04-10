# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :repositories do
      add_column :webhook_enable, TrueClass, default: false
    end
  end
end
