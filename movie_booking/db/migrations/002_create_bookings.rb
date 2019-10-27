# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :bookings do
      primary_key :id

      foreign_key :movie_id, :movies, null: false, index: true, on_delete: :cascade

      String :first_name, null: false
      String :last_name, null: false

      column :booked_at,  DateTime, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
