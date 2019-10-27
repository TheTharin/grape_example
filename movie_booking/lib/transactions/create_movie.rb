# frozen_string_literal: true

class CreateMovie
  include Dry::Transaction

  step :validate
  step :create

  private

  def validate(input)
    validation = MovieValidation.new.call(input)

    if validation.success?
      Success(input)
    else
      Failure(errors: validation.errors.to_h, code: 400)
    end
  end

  def create(input)
    Movie.create(normalized_input(input))

    Success(message: 'Movie successfully created')
  rescue ::Sequel::Error
    Failure(Common::Errors.server_error)
  end

  # TODO: Methods down below are subject to be placed in some sort of a Normalizer,
  # though for now we'll leave them be here for the sake of simplicity
  def normalized_input(input)
    input.merge(week_days: normalized_week_days(input[:week_days]))
  end

  def normalized_week_days(week_days)
    Sequel.pg_array(week_days.uniq)
  end
end
