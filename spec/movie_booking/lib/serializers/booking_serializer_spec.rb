# frozen_string_literal: true

require 'spec_helper'

describe BookingSerializer do
  subject { described_class }
  let(:movie) { create(:movie) }
  let(:booking) { create(:booking, movie_id: movie.id) }

  it 'serializes booking data' do
    expect(subject.call(booking.values)).to eq(id: booking.id,
                                               movie_title: movie.title,
                                               first_name: booking.first_name,
                                               last_name: booking.last_name,
                                               booked_at: 'Sunday, 06 Nov 12:00 am')
  end
end
