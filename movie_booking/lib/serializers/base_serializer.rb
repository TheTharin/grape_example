# frozen_string_literal: true

class BaseSerializer
  class << self
    private

    def without_timestamps(values)
      values.reject { |key, _| %i[created_at updated_at].index(key) }
    end
  end
end
