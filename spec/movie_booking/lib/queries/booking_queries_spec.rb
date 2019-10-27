# frozen_string_literal: true

require 'spec_helper'

describe BookingQueries::ByDateRange do
  subject { described_class }

  let!(:movie) { create(:movie, week_days: [0, 2]) }
  let!(:booking1) { create(:booking, movie_id: movie.id, booked_at: '2011-11-06 12:55') }
  let!(:booking2) { create(:booking, movie_id: movie.id, booked_at: '2011-11-13 13:14') }
  let!(:booking3) { create(:booking, movie_id: movie.id, booked_at: '2011-11-08 10:10') }
  let!(:booking4) { create(:booking, movie_id: movie.id, booked_at: '2011-11-09 01:00') }

  describe '.call' do
    it 'returns a success with movies based on week day' do
      expect(subject.call('2011-11-06', '2011-11-09 00:55').value!).to eq([booking1, booking3])
    end

    context 'when no movies for this week day exist' do
      it 'a failure with error' do
        expect(subject.call('2011-11-10', '2011-11-11').failure?).to be_truthy
      end
    end
  end
end
