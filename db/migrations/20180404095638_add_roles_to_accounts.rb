# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:account_roles, %w[regular admin])

    alter_table :accounts do
      add_column :roles, 'account_roles', null: false, default: 'regular'
    end
  end
end
