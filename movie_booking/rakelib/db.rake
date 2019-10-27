# frozen_string_literal: true

require 'sequel'
require 'yaml'

require File.expand_path('./movie_booking/config.rb')

db_conf = ->(env) { MovieBooking::Config::DB_CONFIG[env] }

ENV['RACK_ENV'] ||= 'development'

namespace :db do # rubocop:disable Metrics/BlockLength
  desc 'Create DB'
  task :create do
    Sequel.connect(db_conf.call('development').merge('database' => 'postgres')) do |db|
      if ENV['RACK_ENV'] == 'development'
        %w[development test].each do |env|
          db.execute("CREATE DATABASE #{db_conf.call(env)['database']}")
        end
      end
    end
  end

  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    require 'sequel/core'

    Sequel.extension :migration
    version = args[:version].to_i if args[:version]

    if ENV['RACK_ENV'] == 'development'
      %w[development test].each do |env|
        Sequel.connect(db_conf.call(env)['database']) do |db|
          Sequel::Migrator.run(db, './movie_booking/db/migrations', target: version)
        end
      end
    else
      Sequel.connect(db_conf.call('production')['database']) do |db|
        Sequel::Migrator.run(db, './movie_booking/db/migrations', target: version)
      end
    end
  end
end
