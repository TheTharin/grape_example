# frozen_string_literal: true

FactoryBot.define do
  factory :booking, class: 'Booking' do
    to_create(&:save)

    movie_id { create(:movie).id }
    first_name { Faker::Book.unique.title }
    last_name { Faker::Game.genre }
    booked_at { '2011-11-06' }
  end
end
