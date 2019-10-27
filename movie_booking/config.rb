# frozen_string_literal: true

require 'erb'

module MovieBooking
  class Config
    DB_CONFIG =
      YAML.load(
        ::ERB.new(
          File.read(
            File.expand_path('./db/database.yml', __dir__)
          )
        ).result
      )
  end
end
