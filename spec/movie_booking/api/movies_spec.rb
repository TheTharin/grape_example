# frozen_string_literal: true

require 'spec_helper'

describe MovieBooking::Movies do # rubocop:disable Metrics/BlockLength
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  describe 'GET /api/movies' do
    context 'when movies exist' do
      let!(:movie1) { create(:movie, week_days: [1, 2]) }
      let!(:movie2) { create(:movie, week_days: [2, 3]) }
      let!(:movie3) { create(:movie, week_days: [3, 4]) }

      it 'returns a list of movies for Tuesday' do
        get '/api/movies?week_day=2'
        parsed_body = JSON.parse(last_response.body)

        expect([movie1.id, movie1.title]).to eq([parsed_body.first['id'],
                                                 parsed_body.first['title']])

        expect([movie2.id, movie2.title]).to eq([parsed_body.last['id'],
                                                 parsed_body.last['title']])
      end
    end

    context 'when movies do not exist' do
      let!(:movie1) { create(:movie, week_days: [1, 2]) }

      it 'returns an error message' do
        get '/api/movies?week_day=3'
        parsed_body = JSON.parse(last_response.body)

        expect(parsed_body['errors']['movies']).to include('Not Found')
        expect(parsed_body['code']).to eq(404)
      end
    end
  end

  describe 'POST /api/movies' do # rubocop:disable Metrics/BlockLength
    context 'when valid params' do
      let(:valid_params) do
        { title: 'Something',
          description: 'Some long description',
          cover_url: 'https://someurl.com',
          week_days: [0, 1, 2, 3] }
      end

      before do
        header 'Content-Type', 'application/json'
      end

      it 'returns a list of movies for Tuesday' do
        post '/api/movies', valid_params.to_json

        parsed_body = JSON.parse(last_response.body)

        expect(parsed_body['message']).to eq('Movie successfully created')
      end
    end

    context 'when invalid_params' do
      let(:invalid_params) do
        { title: 'Something',
          description: 'Some long description',
          cover_url: 'someurl',
          week_days: [0, 1, 2, 3] }
      end

      before do
        header 'Content-Type', 'application/json'
      end

      it 'returns an error message' do
        post '/api/movies', invalid_params.to_json

        parsed_body = JSON.parse(last_response.body)

        expect(parsed_body['errors']['cover_url']).to include('is not a url')
        expect(parsed_body['code']).to eq(400)
      end
    end
  end
end
