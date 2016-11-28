require 'rails/railtie'
require 'logger/metadata/middleware'

class Logger
  module Metadata
    # Rails integration. Inject metadata-awareness to current Rails logger.
    class Railtie < Rails::Railtie
      initializer after: :initialize_logger do |app|
        Metadata.inject ::Rails.logger
        app.middleware.insert_before(::Rails::Rack::Logger, Middleware)
      end
    end
  end
end
