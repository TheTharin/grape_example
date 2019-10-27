# frozen_string_literal: true

module Common
  class Errors
    class << self
      def server_error
        { errors: { base: ['Something went wrong'], code: 500 } }
      end

      def not_found(key)
        { errors: { key => ['Not Found'] }, code: 404 }
      end
    end
  end
end
