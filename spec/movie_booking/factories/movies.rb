# frozen_string_literal: true

FactoryBot.define do
  factory :movie, class: 'Movie' do
    to_create(&:save)

    title { Faker::Alphanumeric.unique.alpha(number: 15) }
    description { Faker::Game.genre }
    cover_url { Faker::Internet.url }
    week_days { [0] }
  end
end
