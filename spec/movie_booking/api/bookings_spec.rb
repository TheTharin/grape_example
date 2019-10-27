# frozen_string_literal: true

require 'spec_helper'

describe MovieBooking::Bookings do # rubocop:disable Metrics/BlockLength
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  describe 'GET /api/bookings' do # rubocop:disable Metrics/BlockLength
    context 'when movies exist' do
      let!(:movie) { create(:movie) }
      let!(:booking1) do
        create(:booking, movie_id: movie.id, booked_at: DateTime.parse('2011-11-06'))
      end

      let!(:booking2) do
        create(:booking, movie_id: movie.id, booked_at: DateTime.parse('2011-11-07'))
      end

      let!(:booking3) do
        create(:booking, movie_id: movie.id, booked_at: DateTime.parse('2011-11-09'))
      end

      it 'returns a list of bookings for given date range' do
        get '/api/bookings?from_date=2011-11-06&to_date=2011-11-08'
        parsed_body = JSON.parse(last_response.body)

        expect([booking1.id, movie.title]).to eq([parsed_body.first['id'],
                                                  parsed_body.first['movie_title']])

        expect([booking2.id, movie.title]).to eq([parsed_body.last['id'],
                                                  parsed_body.last['movie_title']])
      end
    end

    context 'when bookings do not exist' do
      let!(:movie) { create(:movie) }

      let!(:booking1) do
        create(:booking, movie_id: movie.id, booked_at: DateTime.parse('2011-11-08'))
      end

      it 'returns an error message' do
        get '/api/bookings?from_date=2011-11-06&to_date=2011-11-07'
        parsed_body = JSON.parse(last_response.body)

        expect(parsed_body['errors']['bookings']).to include('Not Found')
        expect(parsed_body['code']).to eq(404)
      end
    end
  end
  describe 'POST /api/bookings' do # rubocop:disable Metrics/BlockLength
    let!(:movie) { create(:movie) }

    context 'when valid params' do
      let(:valid_params) do
        { movie_id: movie.id,
          first_name: 'Bob',
          last_name: 'Kelso',
          booked_at: '2011-11-06' }
      end

      before do
        header 'Content-Type', 'application/json'
      end

      it 'returns a list of movies for Tuesday' do
        post '/api/bookings', valid_params.to_json

        parsed_body = JSON.parse(last_response.body)

        expect(parsed_body['message']).to eq('Booking successfully created')
      end
    end

    context 'when invalid_params' do
      let(:invalid_params) do
        { movie_id: 2,
          first_name: 'Bob',
          last_name: 'Kelso',
          booked_at: '2011-11-06' }
      end

      before do
        header 'Content-Type', 'application/json'
      end

      it 'returns an error message' do
        post '/api/bookings', invalid_params.to_json

        parsed_body = JSON.parse(last_response.body)

        expect(parsed_body['errors']['movie_id']).to include("doesn't exist")
        expect(parsed_body['code']).to eq(400)
      end
    end
  end
end
