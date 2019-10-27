# frozen_string_literal: true

module MovieBooking
  class API < Grape::API
    prefix :api

    format :json
    content_type :json, 'application/json'

    mount MovieBooking::Movies
    mount MovieBooking::Bookings
  end
end
