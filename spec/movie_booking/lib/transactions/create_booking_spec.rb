# frozen_string_literal: true

require 'spec_helper'

describe CreateBooking do
  subject { described_class.new }
  let(:movie) { create(:movie) }

  let(:params) do
    { movie_id: movie.id,
      first_name: 'Bob',
      last_name: 'Kelso',
      booked_at: '2011-11-06' }
  end

  let(:invalid_params) do
    { first_name: 'Bob',
      last_name: 'Kelso',
      booked_at: '2011-11-06' }
  end

  it 'creates a movie and returns a success' do
    expect(subject.call(params).value!).to eq(message: 'Booking successfully created')
  end

  it 'validates data' do
    expect(subject.call(invalid_params).failure?).to be_truthy
  end
end
