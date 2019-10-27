# frozen_string_literal: true

class BookingValidation < ApplicationContract
  params do
    required(:movie_id).filled(:integer)
    required(:first_name).filled(:string)
    required(:last_name).filled(:string)
    required(:booked_at).filled(:date_time)
  end

  rule(:movie_id) do
    key.failure("doesn't exist") unless Movie[value]
  end

  rule(:booked_at) do
    movie_id = values.data[:movie_id]
    if wrong_week_day?(movie_id, value)
      key.failure('movie is not being shown on this date')
    elsif already_full?(movie_id, value)
      key.failure('seating only accomodates up to 10 people')
    end
  end

  private

  def wrong_week_day?(movie_id, booked_at)
    booked_on = booked_at.wday
    movie = Movie[movie_id]

    return false if movie&.week_days&.index(booked_on)

    true
  end

  def already_full?(movie_id, booked_at)
    booked_day = booked_at.beginning_of_day
    next_day = booked_day + 1.day

    Booking.where(movie_id: movie_id, booked_at: (booked_day..next_day)).count >= 10
  end
end
