# frozen_string_literal: true

require 'spec_helper'

describe MovieSerializer do
  subject { described_class }

  let(:movie) { create(:movie, week_days: [0, 2, 4]) }

  it 'serializes movie data' do
    expect(subject.call(movie.values)).to eq(id: movie.id,
                                             title: movie.title,
                                             description: movie.description,
                                             cover_url: movie.cover_url,
                                             week_days: %w[Sunday Tuesday Thursday])
  end
end
