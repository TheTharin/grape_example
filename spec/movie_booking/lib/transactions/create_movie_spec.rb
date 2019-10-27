# frozen_string_literal: true

require 'spec_helper'

describe CreateMovie do
  subject { described_class.new }

  let(:params) do
    { title: 'Something',
      description: 'Some long description',
      cover_url: 'https://someurl.com',
      week_days: [0, 1, 2, 3] }
  end

  let(:invalid_params) do
    { description: 'Some long description',
      cover_url: 'https://someurl.com',
      week_days: [0, 1, 2, 3] }
  end

  it 'creates a movie and returns a success' do
    expect(subject.call(params).value!).to eq(message: 'Movie successfully created')
  end

  it 'validates data' do
    expect(subject.call(invalid_params).failure?).to be_truthy
  end
end
