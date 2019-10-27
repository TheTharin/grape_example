# frozen_string_literal: true

class CreateBooking
  include Dry::Transaction

  step :validate
  step :create

  private

  def validate(input)
    validation = BookingValidation.new.call(input)

    if validation.success?
      Success(input)
    else
      Failure(errors: validation.errors.to_h, code: 400)
    end
  end

  def create(input)
    Booking.create(input)

    Success(message: 'Booking successfully created')
  rescue ::Sequel::Error
    Failure(Common::Errors.server_error)
  end
end
