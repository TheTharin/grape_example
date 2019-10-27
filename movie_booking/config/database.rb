# frozen_string_literal: true

DB = Sequel.connect(MovieBooking::Config::DB_CONFIG[ENV['RACK_ENV']]['database'])
DB.extension :pg_array
Sequel::Model.plugin :timestamps, update_on_create: true
