# frozen_string_literal: true

require_relative 'base_serializer'

class MovieSerializer < BaseSerializer
  class << self
    def call(values)
      with_human_week_days(
        without_timestamps(values)
      )
    end

    private

    def with_human_week_days(values)
      values.merge(week_days: values[:week_days].map { |day| Common::DAYS[day] })
    end
  end
end
