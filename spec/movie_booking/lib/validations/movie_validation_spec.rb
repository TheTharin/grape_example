# frozen_string_literal: true

require 'spec_helper'

describe MovieValidation do # rubocop:disable Metrics/BlockLength
  subject { described_class.new }

  let(:params) do
    { 'title' => 'Something',
      'description' => 'Some long description',
      'cover_url' => 'https://someurl.com',
      'week_days' => [0, 1, 2, 3] }
  end

  it 'passes validation' do
    expect(subject.call(params).success?).to be_truthy
  end

  context 'when values are missing' do
    let(:params) { {} }

    it 'fails validation' do
      expect(subject.call(params).errors[:title]).to include('is missing')
      expect(subject.call(params).errors[:description]).to include('is missing')
      expect(subject.call(params).errors[:cover_url]).to include('is missing')
      expect(subject.call(params).errors[:week_days]).to include('is missing')
    end
  end

  context 'when values are not filled' do
    let(:params) do
      {
        title: '',
        description: '',
        cover_url: '',
        week_days: []
      }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:title]).to include('must be filled')
      expect(subject.call(params).errors[:description]).to include('must be filled')
      expect(subject.call(params).errors[:cover_url]).to include('must be filled')
      expect(subject.call(params).errors[:week_days]).to include('must be filled')
    end
  end

  context 'when values are wrong type' do
    let(:params) do
      {
        title: 2,
        description: 2,
        cover_url: 2,
        week_days: 2
      }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:title]).to include('must be a string')
      expect(subject.call(params).errors[:description]).to include('must be a string')
      expect(subject.call(params).errors[:cover_url]).to include('must be a string')
      expect(subject.call(params).errors[:week_days]).to include('must be an array')
    end
  end

  context 'when title is not unique' do
    let(:movie) { create(:movie) }

    let(:params) do
      { title: movie.title,
        description: 'Some long description',
        cover_url: 'https://someurl.com',
        week_days: [0, 1, 2, 3] }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:title]).to include('already exists')
    end
  end

  context 'when cover_url is not a url' do
    let(:params) do
      { title: 'Some title',
        description: 'Some long description',
        cover_url: 'something',
        week_days: [0, 1, 2, 3] }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:cover_url]).to include('is not a url')
    end
  end

  context 'when week_days contains an invalid week day' do
    let(:params) do
      { title: 'Some title',
        description: 'Some long description',
        cover_url: 'http://something.com',
        week_days: [7] }
    end

    it 'fails validation' do
      expect(subject.call(params).errors[:week_days]).to include('wrong week days')
    end
  end
end
