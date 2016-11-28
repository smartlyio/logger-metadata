require 'action_dispatch'

class Logger
  module Metadata
    # Add request_id as metadata to all Rails requests
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        request = ActionDispatch::Request.new env
        ::Rails.logger.metadata(request_id: request.request_id) do
          @app.call(env)
        end
      end
    end
  end
end
