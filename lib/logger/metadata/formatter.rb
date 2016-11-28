require 'thread'

class Logger
  module Metadata
    module Formatter
      def call(severity, timestamp, program_name, message)
        timestamp_string = '[' + timestamp.to_s + ']'
        formatted_message = "#{faint(timestamp_string)} #{message}#{faint(metadata_text)}"
        super(severity, timestamp, program_name, formatted_message)
      end

      def metadata_stack
        thread_key = @metadata_thread_key ||= "metadata_logging:#{object_id}".freeze
        Thread.current[thread_key] ||= []
      end

      def current_metadata
        metadata_stack.inject({}, &:merge)
      end

      def metadata(attributes)
        push_metadata(attributes)
        yield self
      ensure
        pop_metadata
      end

      def push_metadata(attributes)
        metadata_stack.push attributes
      end

      def pop_metadata(size = 1)
        metadata_stack.pop size
      end

      def clear_metadata!
        metadata_stack.clear
      end

      def metadata_text
        current_metadata.map do |(key, value)|
          " (#{key}=#{value})"
        end.join('')
      end

      def faint(string)
        if string.empty?
          string
        else
          "\e[2m#{string}\e[0m"
        end
      end
    end
  end
end
