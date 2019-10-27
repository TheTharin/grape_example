# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :movies do
      primary_key :id

      String :title, null: false, unique: true
      String :description, null: false, text: true
      String :cover_url, null: false
      column :week_days, 'integer[]', null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
