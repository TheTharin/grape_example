# frozen_string_literal: true

require 'pry'

ENV['RACK_ENV'] = 'test'
require File.expand_path('../movie_booking/config/application.rb', __dir__)

OUTER_APP = Rack::Builder.parse_file('config.ru').first

Dir[File.expand_path('./spec/movie_booking/factories/*.rb', __dir__)].each do |f|
  require f
end

FactoryBot.definition_file_paths << File.expand_path('./movie_booking/factories', __dir__)

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    DatabaseCleaner.clean_with :truncation
  end

  config.after(:each) do
    Faker::UniqueGenerator.clear
  end
end
