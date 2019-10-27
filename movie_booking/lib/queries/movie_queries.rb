# frozen_string_literal: true

require 'dry/monads/all'

module MovieQueries
  class ByWeekDay
    extend Dry::Monads[:result]

    class << self
      def call(week_day)
        movies =
          Movie.order(:id).where(Sequel.lit('week_days @> ARRAY[?]::integer[]', week_day.to_i)).all

        if !movies.empty?
          Success(movies)
        else
          Failure(Common::Errors.not_found(:movies))
        end
      end
    end
  end
end
