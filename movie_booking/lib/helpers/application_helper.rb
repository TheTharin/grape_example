# frozen_string_literal: true

module Helpers
  module ApplicationHelper
    def serialize(serializer, collection)
      collection.map { |entity| serializer.call(entity.values) }
    end
  end
end
