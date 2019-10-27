# frozen_string_literal: true

require 'grape'

module MovieBooking
  class Movies < Grape::API
    helpers ::Helpers::ApplicationHelper

    resources :movies do # rubocop:disable Metrics/BlockLength
      desc 'Get movie list filtered by weekday'
      params do
        requires :week_day, type: Integer, values: ::Common::DAYS.keys
      end

      get do
        movies = MovieQueries::ByWeekDay.call(params[:week_day])
        if movies.success?
          serialize(MovieSerializer,
                    movies.success)
        else
          movies.failure
        end
      end

      desc 'Create a movie'
      params do
        requires :title, type: String
        requires :description, type: String
        requires :cover_url, type: String
        requires :week_days, type: Array
      end
      post do
        result = CreateMovie.new.call(params)

        if result.success?
          result.success
        else
          result.failure
        end
      end
    end
  end
end
