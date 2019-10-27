# frozen_string_literal: true

require_relative 'base_serializer'

class BookingSerializer < BaseSerializer
  class << self
    def call(values)
      with_movie_title(
        with_human_booked_at(
          without_timestamps(values)
        )
      )
    end

    private

    def with_human_booked_at(values)
      values.merge(booked_at: values[:booked_at].strftime('%A, %d %b %l:%M %P'))
    end

    def with_movie_title(values)
      movie_title = Movie[values[:movie_id]].title

      values.reject { |k, _| k == :movie_id }.merge(movie_title: movie_title)
    end
  end
end
