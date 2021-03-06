# frozen_string_literal: true

require 'rack/cors'

module MovieBooking
  class App
    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: %i[get post]
          end
        end

        run App.new
      end.to_app
    end

    def call(env)
      MovieBooking::API.call(env)
    end
  end
end
