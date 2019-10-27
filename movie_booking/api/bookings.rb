# frozen_string_literal: true

require 'grape'

module MovieBooking
  class Bookings < Grape::API
    helpers ::Helpers::ApplicationHelper

    resource :bookings do # rubocop:disable Metrics/BlockLength
      desc 'Get bookings list filtered by weekdays'
      params do
        requires :from_date, type: DateTime
        requires :to_date, type: DateTime
      end

      get do
        bookings = ::BookingQueries::ByDateRange.call(params[:from_date], params[:to_date])
        if bookings.success?
          serialize(BookingSerializer, bookings.success)
        else
          bookings.failure
        end
      end

      desc 'Create a booking'
      params do
        requires :first_name, type: String
        requires :last_name,  type: String
        requires :movie_id,   type: Integer
        requires :booked_at,  type: DateTime
      end

      post do
        result = ::CreateBooking.new.call(params)

        if result.success?
          result.success
        else
          result.failure
        end
      end
    end
  end
end
