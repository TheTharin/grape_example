# frozen_string_literal: true

class MovieValidation < ApplicationContract
  params do
    required(:title).filled(:string)
    required(:description).filled(:string)
    required(:cover_url).filled(:string)
    required(:week_days).filled(:array)
  end

  rule(:title) do
    key.failure('already exists') if Movie.where(title: value).count.positive?
  end

  rule(:cover_url) do
    key.failure('is not a url') unless %r{\A(https?://|www\.)[a-z0-9/-_]+}.match?(value)
  end

  rule(:week_days) do
    key.failure('wrong week days') unless value.reject { |item| (0..6).to_a.index item }.empty?
  end
end
