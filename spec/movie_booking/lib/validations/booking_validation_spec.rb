# frozen_string_literal: true

require 'spec_helper'

describe BookingValidation do # rubocop:disable Metrics/BlockLength
  let!(:movie) { create(:movie, week_days: [0, 1, 2]) }

  subject { described_class.new }

  let(:params) do
    { movie_id: movie.id,
      first_name: 'Bob',
      last_name: 'Kelso',
      booked_at: '2011-11-06' }
  end

  it 'passes validation' do
    expect(subject.call(params).success?).to be_truthy
  end

  context 'when values are missing' do
    let(:params) { {} }

    it 'fails validation' do
      expect(subject.call(params).errors[:movie_id]).to include('is missing')
      expect(subject.call(params).errors[:first_name]).to include('is missing')
      expect(subject.call(params).errors[:last_name]).to include('is missing')
      expect(subject.call(params).errors[:booked_at]).to include('is missing')
    end
  end

  context 'when values are not filled' do
    let(:params) do
      {
        movie_id: nil,
        first_name: '',
        last_name: '',
        booked_at: ''
      }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:movie_id]).to include('must be filled')
      expect(subject.call(params).errors[:first_name]).to include('must be filled')
      expect(subject.call(params).errors[:last_name]).to include('must be filled')
      expect(subject.call(params).errors[:booked_at]).to include('must be filled')
    end
  end

  context 'when values are wrong type' do
    let(:params) do
      {
        movie_id: movie.id,
        first_name: 2,
        last_name: 2,
        booked_at: 2
      }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:first_name]).to include('must be a string')
      expect(subject.call(params).errors[:last_name]).to include('must be a string')
      expect(subject.call(params).errors[:booked_at]).to include('must be a date time')
    end
  end

  context "when movie doesn't exist" do
    let(:params) do
      { movie_id: 2,
        first_name: 'Bob',
        last_name: 'Kelso',
        booked_at: '2011-11-06' }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:movie_id]).to include("doesn't exist")
    end
  end

  context 'when movie is not being shown on that date' do
    let(:params) do
      { movie_id: movie.id,
        first_name: 'Bob',
        last_name: 'Kelso',
        booked_at: '2011-11-09' }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:booked_at])
        .to include('movie is not being shown on this date')
    end
  end

  context 'when there are already 10 or more bookings for that movie and date' do
    let(:movie) { create(:movie, week_days: [2]) }

    let!(:bookings) { create_list(:booking, 10, movie_id: movie.id, booked_at: '2011-11-08') }

    let(:params) do
      { movie_id: movie.id,
        first_name: 'Bob',
        last_name: 'Kelso',
        booked_at: '2011-11-08' }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:booked_at])
        .to include('seating only accomodates up to 10 people')
    end
  end
end
