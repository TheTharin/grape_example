# frozen_string_literal: true

require 'dry/monads/all'

module BookingQueries
  class ByDateRange
    extend Dry::Monads[:result]

    class << self
      def call(from_date, to_date)
        bookings =
          Booking.order(:id).where(booked_at: (from_date..to_date)).all

        if !bookings.empty?
          Success(bookings)
        else
          Failure(Common::Errors.not_found(:bookings))
        end
      end
    end
  end
end
