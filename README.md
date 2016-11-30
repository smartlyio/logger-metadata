# Logger::Metadata

Enhance Ruby logger with support for key-value metadata.

[![Build Status](https://travis-ci.org/smartlyio/logger-metadata.svg?branch=master)](https://travis-ci.org/smartlyio/logger-metadata)

## Installation

Logger::Metadata is available as a ruby gem.

    $ gem install logger-metadata

## Usage

```ruby
require 'logger-metadata'

logger = Logger.new
Logger::Metadata.inject(logger)

logger.metadata(key: 'value') do
  logger.info('message')
end
```

All log messages within the metadata block will contain the metadata. Nested
metadata blocks can be used.

Logger::Metadata will augment the default the default formatter to include
metadata and timestamp. For example

```
[2016-11-30 14:27:19 +0200] Message (key=value)
```

## Rails integration

If you include `logger-metadata` in a Rails application Gemfile, metadata
logging will be automatically set up.
