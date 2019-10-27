# frozen_string_literal: true

require 'spec_helper'

describe MovieQueries::ByWeekDay do
  subject { described_class }

  let!(:movie1) { create(:movie, week_days: [5, 6]) }
  let!(:movie2) { create(:movie, week_days: [4, 5]) }
  let!(:movie3) { create(:movie, week_days: [1, 2]) }

  describe '.call' do
    it 'returns a success with movies based on week day' do
      expect(subject.call(5).value!).to eq([movie1, movie2])
    end

    context 'when no movies for this week day exist' do
      it 'a failure with error' do
        expect(subject.call(3).failure?).to be_truthy
      end
    end
  end
end
