require 'logger'
require 'logger/metadata/version'
require 'logger/metadata/formatter'
require 'logger/metadata/railtie' if defined?(Rails)

class Logger
  # Metadata mixin for Ruby Logger
  module Metadata
    def flush
      clear_metadata!
      super if defined?(super)
    end

    def metadata(attributes)
      formatter.metadata(attributes) { yield self }
    end

    def push_metadata(*args, &block)
      formatter.push_metadata(*args, &block)
    end

    def pop_metadata(*args, &block)
      formatter.pop_metadata(*args, &block)
    end

    def clear_metadata!(*args, &block)
      formatter.clear_metadata!(*args, &block)
    end

    def self.inject(logger)
      logger.formatter ||= default_formatter
      logger.formatter.extend Formatter
      logger.extend(self)
    end

    def self.default_formatter
      if defined?(ActiveSupport::Logger::SimpleFormatter)
        ActiveSupport::Logger::SimpleFormatter
      else
        Logger::Formatter
      end.new
    end
  end
end
